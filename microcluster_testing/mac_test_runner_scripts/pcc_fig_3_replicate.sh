#!/usr/bin/env bash
# Script for running tests on the two graphs from figure 3 of the paper
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)
#
# Note: this script uses round robin

# Usage: ./mc_sparse_er_runner_no_rr_mac.sh INPUT_DIR OUTPUT_DIR MAX_PROCS

#our output_dir=../test_results/pcc_fig_3_results/

output_dir=$1
max_procs=$2

echo "Running tests on rmat_128000_256M.in graph, 1/1" #CHANGE TO 1/2 WHEN FIXED

./pcc_test_mac.sh ../input_graphs/pcc_fig_3_inputs/rmat_128000_256M.in ${max_procs} > ${output_dir}/pcc_rmat_128000_256M.txt

##echo "Running tests on NAME!!!!!!!!!!!!! graph, 2/2"          #TODO: add name in when we get the graph

##./pcc_test_mac.sh ../input_graphs/pcc_fig_3_inputs/NAME!!!!!!!!!!!!!!!.in ${max_procs} > ${output_dir}/pcc_NAME!!!!!!!!!!!!!!!.txt

##DID NOT GENERATE GRAPH IN TIME, run later

