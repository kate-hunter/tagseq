#!/bin/sh
# properties = {"type": "single", "rule": "align_reads", "local": false, "input": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/unzipped/12_S116.trim.fastq"], "output": ["/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/SAM/12_S116/12_S116_Aligned.out.sam"], "wildcards": {"sample": "12_S116"}, "params": {"cpu": 6, "id": "12_S116", "indexdirec": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/genome/indexing", "folder_loca": "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/SAM/12_S116/12_S116_"}, "log": [], "threads": 1, "resources": {"mem_mb": 40000}, "jobid": 6, "cluster": {"cluster": "notchpeak", "partition": "kapheim-shared-np", "account": "kapheim-np"}}
cd /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac && \
/uufs/chpc.utah.edu/sys/installdir/python/3.6.3/bin/python3 \
-m snakemake /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/SAM/12_S116/12_S116_Aligned.out.sam --snakefile /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/snakefile \
--force -j --keep-target-files --keep-remote \
--wait-for-files /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr /uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/fastq_files/GSAF_files_prac/unzipped/12_S116.trim.fastq --latency-wait 10 \
 --attempt 1 --force-use-threads \
--wrapper-prefix https://bitbucket.org/snakemake/snakemake-wrappers/raw/ \
   --allowed-rules align_reads --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr/6.jobfinished" || (touch "/uufs/chpc.utah.edu/common/home/kapheim-group2/nmel_immune_tagseq/kate_practice/nmel_tagseq/scripts/snake/khprac/.snakemake/tmp.t7z7u_mr/6.jobfailed"; exit 1)

