#!/bin/bash
#SBATCH --partition=kapheim-shared-np
#SBATCH --account=kapheim-np
#SBATCH --mem=1GB
#SBATCH --ntasks 1
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=franceskhunter@gmail.com

#bash script for executing snakemake in cluster
#important note yaml files need to have exactly four spaces to constitute an indent
#you can change partition to and from kapheim-kp to kingspeak and account from kapheim-kp kapheim in the yaml file whose name is cluster.yaml
#--error=front-%j.err --job-name=front-%j.out"
#{cluster.cluster}=clusterprefix.cluster

module load snakemake/5.6.0
	snakemake -s snakefile_prac --cluster-config cluster.yaml --jobs 8 \
	--cluster "sbatch --ntasks=1 --time 1:00:00 --mem={resources.mem_mb} --cpus-per-task={params.cpu} -M {cluster.cluster} -A {cluster.account} -p {cluster.partition}" \
	--latency-wait 10

#To run bash script, type in sbatch bash_snake.sh
