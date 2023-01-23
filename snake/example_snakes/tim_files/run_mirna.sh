#!/usr/bin/env bash
#SBATCH --partition=notchpeak-shared
#SBATCH --account=kapheim
#SBATCH --mem=2GB
#SBATCH --ntasks 2
#bash script for executing snakemake in cluster
#important note yaml files need to have exactly four spaces to constitute an indent
#you can change partition to and from kapheim-kp to kingspeak and account from kapheim-kp kapheim in the yaml file whose name is cluster.yaml
#--error=front-%j.err --job-name=front-%j.out"
module load snakemake/5.6.0 
	snakemake -s snake_rna_analysis --restart-times 2 --cluster-config cluster.yaml --jobs 50 \
	--cluster "sbatch --ntasks=1 --time 72:00:00 --mem={resources.mem_mb} --cpus-per-task={params.cpu} -M {cluster.cluster} -A {cluster.account} -p {cluster.partition}" \
	--latency-wait 10 


