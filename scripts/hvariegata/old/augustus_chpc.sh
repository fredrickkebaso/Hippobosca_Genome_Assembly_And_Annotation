1. Make the two changes to common.mk, I assume you do not need CGP?

--
# set COMPGENEPRED to false if you do not require the comparative gene prediction mode (CGP) or
# the required libraries
# libgsl-dev, libboost-all-dev, libsuitesparse-dev, liblpsolve55-dev, libmysql++-dev and libsqlite3-dev
# are not available
#COMPGENEPRED = true
COMPGENEPRED = false
MYSQL = false
---
2. make this change to src/Makefile line 24

INCLS = -I../include -I/apps/chpc/bio/lib/lp_solve_5.5



3. Load the following modules:

module load chpc/BIOMODULES
module add gnu_build_essentials/gcc9+
module add /apps/chpc/scripts/modules/bio/app/sqlite/3.16.2
module add /apps/chpc/scripts/modules/bio/lib/gnu/gsl_2.4
module add /apps/chpc/scripts/modules/bio/lib/lpsolve55
module add bamtools/2.5.1
module add htslib/1.16 


4. Run 'make'  