#!/bin/bash
#SBATCH --partition=kapheim-shared-np
#SBATCH --account=kapheim-np
#SBATCH --mem=3GB
#SBATCH --ntasks 5

cp -R /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/original_data_nmeltag/FASTQ_Generation_2021-03-12_08_15_22Z-389381999/SA21045*/*.fastq.gz /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/tagseq_analysis/original_files/ 

#To run bash script, type in sbatch copying_allfiles.sh

