#!/bin/sh
# properties = {"type": "single", "rule": "clip", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/concatenated/11_S109.cmb.fastq.gz"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/trimmed/11_S109.trim.fastq"], "wildcards": {"sample": "11_S109"}, "params": {"cpu": 1, "input_path": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/concatenated/", "plscript": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/TagSeq_processing_codetagseq_clipper.anna.pl"}, "log": [], "threads": 1, "resources": {"mem_mb": 1000}, "jobid": 4, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
 cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin/python \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/trimmed/11_S109.trim.fastq --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.u6y9e68k /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/concatenated/11_S109.cmb.fastq.gz --latency-wait 10 \
 --attempt 1 --force-use-threads --scheduler greedy \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules clip --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /uufs/chpc.utah.edu/sys/installdir/python/3.7.3/bin \
--mode 2  && touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.u6y9e68k/4.jobfinished || (touch /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.u6y9e68k/4.jobfailed; exit 1)

