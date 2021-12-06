#!/bin/bash
#
#SBATCH --partition=kingspeak
#SBATCH --account=kapheim
#SBATCH --job-name=combining_files
#SBATCH --output=final_output
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=franceskhunter@gmail.com

#SBATCH --ntasks=1
#SBATCH --time=1:00:00

ngs_concat.pl
