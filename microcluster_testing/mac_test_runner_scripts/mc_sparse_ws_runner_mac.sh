#!/usr/bin/env bash
# Script for running tests on multiple sizes of Watts-Strogatz graphs with equally low density (edges over possible edges)
#
# Note that the Watts-Strogatz graphs ran by this script are all named in the format ws_NUMVERTICES_DEGREE.in and the output is named
# mc_ws_NUMVERTICES_DEGREE.txt
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./mc_sparse_ws_runner_mac.sh INPUT_DIR OUTPUT_DIR MAX_PROCS

#our input_dir=../input_graphs/mc_ws_inputs/
#our output_dir=../test_results/mc_sparse_ws_results/

input_dir=$1
output_dir=$2
max_procs=$3

graph_sizes=( 200 300 400 600 800 1200 1600 2400 3200 4800)

for size in "${graph_sizes[@]}"; 
do
	k_neighbors=$((${size}/50))

	echo "Running tests on WS graphs of ${size} vertices and k = ${k_neighbors}"

	./mc_test_mac.sh ${input_dir}/ws_${size}_${k_neighbors}.in ${max_procs} > ${output_dir}/mc_ws_${size}_${degree}.txt

	echo "${size}-vertice graph tests complete"
done
