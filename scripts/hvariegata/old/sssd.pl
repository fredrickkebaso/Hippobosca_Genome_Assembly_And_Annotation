#!/usr/bin/env perl

# Copyright 2013-2021, Derrick Wood <dwood@cs.jhu.edu>
#
# This file is part of the Kraken 2 taxonomic sequence classification system.

# Reads an assembly_summary.txt file, which indicates taxids and FTP paths for
# genome/protein data.  Performs the download of the complete genomes from
# that file, decompresses, and explicitly assigns taxonomy as needed.

use strict;
use warnings;
use File::Basename;
use Getopt::Std;
use Net::FTP;
use List::Util qw/max/;

my $PROG = basename $0;
my $SERVER = "ftp.ncbi.nlm.nih.gov";
my $SERVER_PATH = "/genomes";
my $FTP_USER = "anonymous";
my $FTP_PASS = "kraken2download";

my $qm_server = quotemeta $SERVER;
my $qm_server_path = quotemeta $SERVER_PATH;

my $is_protein = $ENV{"KRAKEN2_PROTEIN_DB"};
my $use_ftp = $ENV{"KRAKEN2_USE_FTP"};

my $suffix = $is_protein ? "_protein.faa.gz" : "_genomic.fna.gz";

# Manifest hash maps filenames (keys) to taxids (values)
my %manifest;
while (<>) {
  next if /^#/;
  chomp;
  my @fields = split /\t/;
  my ($taxid, $asm_level, $ftp_path) = @fields[5, 11, 19];
  # Possible TODO - make the list here configurable by user-supplied flags
  next unless grep {$asm_level eq $_} ("Complete Genome", "Chromosome");
  next if $ftp_path eq "na";  # Skip if no provided path

  my $full_path = $ftp_path . "/" . basename($ftp_path) . $suffix;
  # strip off server/leading dir name to allow --files-from= to work w/ rsync
  # also allows filenames to just start with "all/", which is nice
  if (! ($full_path =~ s#^ftp://${qm_server}${qm_server_path}/##)) {
    die "$PROG: unexpected FTP path (new server?) for $ftp_path\n";
  }
  $manifest{$full_path} = $taxid;
}

open MANIFEST, ">", "manifest.txt"
  or die "$PROG: can't write manifest: $!\n";
print MANIFEST "$_\n" for keys %manifest;
close MANIFEST;

if ($is_protein && ! $use_ftp) {
  print STDERR "Step 0/2: performing rsync dry run (only protein d/l requires this)...\n";
  # Protein files aren't always present, so we have to do this two-rsync run hack
  # First, do a dry run to find non-existent files, then delete them from the
  # manifest; after this, execution can proceed as usual.
  system("rsync --dry-run --no-motd --files-from=manifest.txt rsync://${SERVER}${SERVER_PATH} . 2> rsync.err");
  open ERR_FILE, "<", "rsync.err"
    or die "$PROG: can't read rsync.err file: $!\n";
  while (<ERR_FILE>) {
    chomp;
    # I really doubt this will work across every version of rsync. :(
    if (/failed: No such file or directory/ && /^rsync: link_stat "\/([^"]+)"/) {
      delete $manifest{$1};
    }
  }
  close ERR_FILE;
  print STDERR "Rsync dry run complete, removing any non-existent files from manifest.\n";

  # Rewrite manifest
  open MANIFEST, ">", "manifest.txt"
    or die "$PROG: can't write manifest: $!\n";
  print MANIFEST "$_\n" for keys %manifest;
  close MANIFEST;
}

sub ftp_connection {
    my $ftp = Net::FTP->new($SERVER, Passive => 1)
        or die "$PROG: FTP connection error: $@\n";
    $ftp->login($FTP_USER, $FTP_PASS)
        or die "$PROG: FTP login error: " . $ftp->message() . "\n";
    $ftp->binary()
        or die "$PROG: FTP binary mode error: " . $ftp->message() . "\n";
    $ftp->cwd($SERVER_PATH)
        or die "$PROG: FTP CD error: " . $ftp->message() . "\n";
    return $ftp;
}
