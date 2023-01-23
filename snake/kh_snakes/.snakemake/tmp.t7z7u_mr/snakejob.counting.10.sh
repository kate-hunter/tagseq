#!/bin/sh
# properties = {"type": "single", "rule": "counting", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/SAM/10_S111/10_S111_Aligned.out.sam"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/counts_10_S111.txt"], "wildcards": {"sample": "10_S111"}, "params": {"cpu": 1, "gff": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/genome/genome_files/NMEL_OGS_v2.1.0.gff3", "id": "10_S111"}, "log": [], "threads": 1, "resources": {}, "jobid": 10, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.6.3/bin/python3 \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/htseq/counts_10_S111.txt --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/SAM/10_S111/10_S111_Aligned.out.sam --latency-wait 10 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules counting --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr/10.jobfinished" || (touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr/10.jobfailed"; exit 1)

