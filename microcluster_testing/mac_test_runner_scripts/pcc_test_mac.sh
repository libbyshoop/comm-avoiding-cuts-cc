#!/usr/bin/env bash
# Script for running parallel connected components trials on an input graph with varying numbers of processes; 

# Note you need to input your host file. With parallel cc we opt to use round robin. 
# Parallel_cc can handle very large inputs that may cause the system to crash due 
# to lack of memory if all the cores on a single node are loaded up with too much 
# of the data. In your hostfile, simply list each node's name on each line.

# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./pcc_test_mac.sh GRAPH.in HOST_FILE MAX_PROCS > OUTPUT.txt 

input=$1
host_file=$2	#our host file: /media/cluster_files/cluster_nodes_rr (remove _rr for not round robin, however this may overstress the memory)
max_procs=$3

processes=( 3 4 5 6 8 10 12 16 20 24 32 40 )

for proc_count in "${processes[@]}"; 
do
	if [ $proc_count -gt $max_procs ]
	then
		break
	fi
 
	trials=1

	while [ ${trials} -le 5 ] 
	do
		seed=$RANDOM

		mpirun -f ${host_file} -np ${proc_count} ../../../src/executables/parallel_cc ${input} ${seed}

		((trials++)) 	
	done
done
