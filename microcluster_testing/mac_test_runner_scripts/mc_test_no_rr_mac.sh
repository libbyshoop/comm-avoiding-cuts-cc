#!/usr/bin/env bash
# Script for running mincut trials on an input graph with varying numbers of processes; 
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./mc_test_no_rr_mac.sh GRAPH.in MAX_PROCS > OUTPUT.txt 


input=$1
max_procs=$2

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

		#We opt to NOT use round robin in with the min cuts. This better utilizes
		#the communication-avoiding structure of the algorithms. Note, also, that
		#square_root cannot handle graphs large enough to cause an issue with 
		#the memory as a result of not using round robin, so this is fine.

		mpirun -f /media/cluster_files/cluster_nodes -np ${proc_count} ../../../src/executables/square_root 0.9 ${input} ${seed}

		((trials++)) 	
	done
done

