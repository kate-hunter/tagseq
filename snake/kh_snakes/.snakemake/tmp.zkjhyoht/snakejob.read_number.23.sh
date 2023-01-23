#!/bin/sh
# properties = {"type": "single", "rule": "read_number", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/outputsfolder/10_S111"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/outputsfolder/10_S111.summary"], "wildcards": {"sample": "10_S111"}, "params": {"cpu": 1}, "log": [], "threads": 1, "resources": {"mem_mb": 1000}, "jobid": 23, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
 cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin/python \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/outputsfolder/10_S111.summary --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.zkjhyoht /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/outputsfolder/10_S111 --latency-wait 10 \
 --attempt 1 --force-use-threads --scheduler greedy \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules read_number --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin \
--mode 2  && touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.zkjhyoht/23.jobfinished || (touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.zkjhyoht/23.jobfailed; exit 1)

