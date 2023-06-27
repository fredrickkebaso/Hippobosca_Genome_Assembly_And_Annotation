#!/usr/bin/env python

#Calculates insertsizes from the raw reads

import argparse
import numpy as np
from Bio import SeqIO

def parse_args():
    parser = argparse.ArgumentParser(description='Calculate insert size distribution from paired-end reads.')
    parser.add_argument('-f', '--read1', required=True, help='Input FASTQ file for read 1')
    parser.add_argument('-r', '--read2', required=True, help='Input FASTQ file for read 2')
    parser.add_argument('-o', '--output', required=True, help='Output file for insert size distribution')
    parser.add_argument('-p', '--plot', required=True, help='Output file for insert size distribution plot')
    parser.add_argument('-s', '--sample_size', default=None, type=int, help='Number of reads to sample (default: all reads)')
    return parser.parse_args()

def sample_reads(read1, read2, sample_size):
    """Randomly sample reads from two paired-end files."""
    records1 = list(SeqIO.parse(read1, 'fastq'))
    records2 = list(SeqIO.parse(read2, 'fastq'))
    if sample_size is not None:
        if sample_size > len(records1) or sample_size > len(records2):
            raise ValueError('Sample size cannot exceed number of reads.')
        indices = np.random.choice(len(records1), sample_size, replace=False)
        records1 = [records1[i] for i in indices]
        records2 = [records2[i] for i in indices]
    return records1, records2

def calculate_insert_sizes(records1, records2):
    """Calculate insert sizes from two lists of paired-end reads."""
    insert_sizes = []
    for i in range(len(records1)):
        if records1[i].id != records2[i].id:
            raise ValueError('Read IDs do not match: %s vs. %s' % (records1[i].id, records2[i].id))
        insert_size = abs(len(records1[i]) - len(records2[i]))
        insert_sizes.append(insert_size)
    return insert_sizes

def main():
    args = parse_args()
    records1, records2 = sample_reads(args.read1, args.read2, args.sample_size)
    insert_sizes = calculate_insert_sizes(records1, records2)
    mean = np.mean(insert_sizes)
    stdev = np.std(insert_sizes)
    mode = np.bincount(insert_sizes).argmax()
    with open(args.output, 'w') as f:
        f.write('Mean insert size: %d\n' % mean)
        f.write('Standard deviation: %d\n' % stdev)
        f.write('Mode: %d\n' % mode)
        f.write('\n'.join(map(str, insert_sizes)))
    import matplotlib.pyplot as plt
    plt.hist(insert_sizes, bins=50)
    plt.xlabel('Insert size')
    plt.ylabel('Frequency')
    plt.title('Insert size distribution')
    plt.savefig(args.plot)

if __name__ == '__main__':
    main()
