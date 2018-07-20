#!/usr/bin/env bash
# Script for running tests on multiple sizes of RMAT graphs with equal and high density (edges to possible edges ratio)
#
# Note that the RMAT graphs ran by this script are all named in the format rmat_NUMVERTICES_NUMEDGES.in and the output is named
# mc_rmat_NUMVERTICES_NUMEDGES.txt
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./mc_dense_rmat_runner_mac.sh INPUT_DIR OUTPUT_DIR MAX_PROCS

#our input_dir=../input_graphs/mc_rmat_inputs/
#our output_dir=../test_results/mc_rmat_results/

input_dir=$1
output_dir=$2
max_procs=$3

graph_sizes=( 50 100 150 200 300 400 600 800 1200 1600)

for size in "${graph_sizes[@]}"; 
do
	avg_total_degree=$((${size}/2))

	edges=$((${size}*${avg_total_degree}/2))

	echo "Running tests on graphs of ${size} vertices with ${edges} edges"

	./mc_test_mac.sh ${input_dir}/rmat_${size}_${edges}.in ${max_procs} > ${output_dir}/mc_rmat_${size}_${edges}.txt

	echo "${size}-vertice graph tests complete"
done
