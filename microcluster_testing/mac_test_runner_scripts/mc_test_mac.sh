#!/usr/bin/env bash
# Script for running mincut trials on an input graph with varying numbers of processes and round robin; 

# Note that you will need to input your host file. We opt to NOT use round robin 
# in with the min cuts. This better utilizes the communication-avoiding structure 
# of the algorithms. Note, also, that square_root cannot handle graphs large enough 
# to cause an issue with the memory as a result of not using round robin, so this is fine.
# In order to enforce not round robin, we list our host names in our host file and
# add a :4 next to each one

#TODO: maybe change comment above, if we change our mind about round robin

# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./mc_test_mac.sh GRAPH.in HOST_FILE MAX_PROCS > OUTPUT.txt 


input=$1
host_file=$2	#our hostfile: /media/cluster_files/cluster_nodes (and we add _rr for testing round robin) #TODO: change if needed
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

		mpirun -f ${host_file} -np ${proc_count} ../../../src/executables/square_root 0.9 ${input} ${seed}

		((trials++)) 	
	done
done

