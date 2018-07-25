#!/usr/bin/env bash
# Script for running tests on multiple sizes of Erdos-Renyi graphs with equal sparsity (average degree to vertice ratio)
#
# Note that the Erdos-Renyi graphs ran by this script are all named in the format er_NUMVERTICES_DEGREE.in and the output is named
# mc_er_NUMVERTICES_DEGREE.txt
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

# NOTE: THIS SCRIPT USES ROUND ROBIN SCHEDULING. This is not our standard scheduling process when
# testing the mininum cut algorithms. This script is for testing the difference between rr and without.

# Usage: ./mc_sparse_er_runner_rr_mac.sh INPUT_DIR OUTPUT_DIR MAX_PROCS

#our input_dir=../input_graphs/mc_er_inputs/
#our output_dir=../test_results/mc_sparse_er_results/

input_dir=$1
output_dir=$2
max_procs=$3

graph_sizes=( 200 400 600 800 1200 1600 2400 3200 4800)

for size in "${graph_sizes[@]}"; 
do
	degree=$((${size}/100))

	echo "Running tests on graphs of ${size} vertices and avg deg: ${degree}"

	./mc_test_rr_mac.sh ${input_dir}/er_${size}_${degree}.in ${max_procs} > ${output_dir}/mc_er_rr_${size}_${degree}.txt

	echo "${size}-vertice graph tests complete"
done

