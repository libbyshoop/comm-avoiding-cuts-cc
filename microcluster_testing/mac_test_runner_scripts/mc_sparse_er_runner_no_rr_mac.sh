#!/usr/bin/env bash
# Script for running tests on multiple sizes of Erdos-Renyi graphs with equal sparsity (average degree to vertice ratio)
#
# Note that the Erdos-Renyi graphs ran by this script are all named in the format er_NUMVERTICES_DEGREE.in and the output is named
# mc_er_NUMVERTICES_DEGREE.txt
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#NOTE: THIS SCRIPT DOES NOT USE ROUND ROBIN SCHEDULING. This is our standard scheduling for the min
#cut experiments, as it makes the best use of the communication-avoiding structure of the algorithm.
#There is another script using round robin on Erdos-Renyi graphs for testing/comparison purposes.

# Usage: ./mc_sparse_er_runner_no_rr_mac.sh INPUT_DIR OUTPUT_DIR HOST_FILE MAX_PROCS

#our input_dir=../input_graphs/mc_er_inputs/
#our output_dir=../test_results/mc_sparse_er_no_rr_results/

input_dir=$1
output_dir=$2
host_file=$3	#our hostfile: /media/cluster_files/cluster_nodes
max_procs=$4

graph_sizes=( 200 400 600 800 1200 1600 2400 3200 4800)

for size in "${graph_sizes[@]}"; 
do
	degree=$((${size}/100))

	echo "Running tests on graphs of ${size} vertices and avg deg: ${degree}"

	./mc_test_mac.sh ${input_dir}/er_${size}_${degree}.in ${host_file} ${max_procs} > ${output_dir}/mc_er_no_rr_${size}_${degree}.txt

	echo "${size}-vertice graph tests complete"
done

