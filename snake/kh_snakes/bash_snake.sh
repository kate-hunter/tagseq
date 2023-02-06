#!/bin/bash
#SBATCH --partition=kapheim-shared-np
#SBATCH --account=kapheim-np
#SBATCH --mem=4GB
#SBATCH --ntasks 20

#bash script for executing snakemake in cluster
#important note yaml files need to have exactly four spaces to constitute an indent


module load snakemake/6.4.1
	snakemake -s snakefile --cluster-config cluster.yaml --jobs 20 \
	--cluster "sbatch --ntasks=20 --time 1:00:00 --mem={resources.mem_mb} --cpus-per-task={params.cpu} -M {cluster.cluster} -A {cluster.account} -p {cluster.partition}" \
	--latency-wait 10

#To run bash script, type in sbatch bash_snake.sh
