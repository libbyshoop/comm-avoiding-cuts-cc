#!/usr/bin/env bash
# Script for running tests on multiple sizes of Erdos-Renyi graphs, all degree 32
#
# Note that the Erdos-Renyi graphs ran by this script are all named in the format er_NUMVERTICES_DEGREE.in and the output is named
# mc_er_NUMVERTICES_DEGREE.txt
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)

#Usage: ./mc_er_runner_mac.sh INPUT_DIR OUTPUT_DIR HOST_FILE MAX_PROCS

#our input_dir=../input_graphs/mc_er_inputs/
#our output_dir=.../test_results/mc_er_results/

input_dir=$1
output_dir=$2
host_file=$3
max_procs=$4

degree=32
graph_sizes=( 200 400 600 800 1200 1600 2400 3200)

for size in "${graph_sizes[@]}"; 
do
	echo "Running tests on graphs of ${size} vertices"

	./mc_test_mac.sh ${input_dir}/er_${size}_${degree}.in ${host_file} ${max_procs} > ${output_dir}/mc_er_${size}_${degree}.txt

	echo "${size}-vertice graph tests complete"
done
