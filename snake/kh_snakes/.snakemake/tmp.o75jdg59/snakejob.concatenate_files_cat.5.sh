#!/bin/sh
# properties = {"type": "single", "rule": "concatenate_files_cat", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq", "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L002_R1_001.fastq"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_merged.fastq"], "wildcards": {"sample": "10_S102"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 5, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.6.3/bin/python3 \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_merged.fastq --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile_prac \
--force -j --keep-target-files --keep-remote \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.o75jdg59 /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L002_R1_001.fastq --latency-wait 10 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules concatenate_files_cat --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.o75jdg59/5.jobfinished" || (touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.o75jdg59/5.jobfailed"; exit 1)

