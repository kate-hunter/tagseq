#!/bin/sh
# properties = {"type": "single", "rule": "create_one_dot_foo_file", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq.gz"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq"], "wildcards": {"sample": "10_S102_L001"}, "params": {"cpu": 1}, "log": [], "threads": 1, "resources": {"mem_mb": 1000}, "jobid": 1, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.6.3/bin/python3 \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile_prac \
--force -j --keep-target-files --keep-remote \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.kqteth3s /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_practice/10_S102_L001_R1_001.fastq.gz --latency-wait 10 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules create_one_dot_foo_file --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.kqteth3s/1.jobfinished" || (touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.kqteth3s/1.jobfailed"; exit 1)

