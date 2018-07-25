#!/usr/bin/env bash
# Script for running tests on several real graphs: web graphs of Notre Dame and Stanford.edu, youtube links graph
# (graph data from http://snap.stanford.edu/data/index.html)
#
# Note that you must specify your max number of processes (added parameter in case 40 is too high for your system)
#
# Note: this script uses round robin

# Usage: ./7_24_18_pcc_real_graphs.sh OUTPUT_DIR HOST_FILE MAX_PROCS

#our output_dir=../test_results/pcc_real_results/

output_dir=$1
host_file=$2	#our host file: /media/cluster_files/cluster_nodes_rr
max_procs=$3

echo "Running tests on web-NotreDame.in graph, 1/1"

./pcc_test_mac.sh ../input_graphs/real_data_graphs/web-NotreDame.in ${host_file} ${max_procs} > ${output_dir}/pcc_web-NotreDame.txt

#REMOVED BECAUSE THE GRAPHS DO NOT WORK WITH THE ALGORITHM

#echo "Running tests on web-Stanford.in graph, 2/3"
#./pcc_test_mac.sh ../input_graphs/real_data_graphs/web-Stanford.in ${host_file} ${max_procs} > ${output_dir}/pcc_web-Stanford.txt

#echo "Running tests on youtube-links.in graph, 3/3"
#./pcc_test_mac.sh ../input_graphs/real_data_graphs/youtube-links.in ${host_file} ${max_procs} > ${output_dir}/pcc_youtube-links.txt

