#!/bin/sh
# properties = {"type": "single", "rule": "combine_matrices_htseq", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/strandedisreverse"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/matrix.csv"], "wildcards": {}, "params": {"cpu": 1, "concat_script": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/Rstuff/htseq_scriptconcat.R"}, "log": [], "threads": 1, "resources": {"mem_mb": 1000}, "jobid": 14, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
 cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin/python \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/matrix.csv --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.4_6fbvqo /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/strandedisreverse --latency-wait 10 \
 --attempt 1 --force-use-threads --scheduler greedy \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules combine_matrices_htseq --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin \
--mode 2  && touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.4_6fbvqo/14.jobfinished || (touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.4_6fbvqo/14.jobfailed; exit 1)

