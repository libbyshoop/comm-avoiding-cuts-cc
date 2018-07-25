#!/usr/bin/env bash
# Script for running tests overnight on 7/24/18, runs a variety of experiments: 
# erdos renyi sparse no round robin w/ mincut, 3 real world graphs w/ pcc, 2 large graphs from fig 3 w/ pcc
# Note that these experiments are not very related to each other, and this script
# was only written to run the separate experiments all in one night. 

# CAREFUL: running this could overwrite previous experiment results; script really only meant to be used once
# 		   in case anything is overwritten, however, the results are on the github repository

# Usage: ./7_24_18_experiments.sh HOST_FILE MAX_PROCS

host_file=$1	#our host file: /media/cluster_files/cluster_nodes_rr
max_procs=$2	

echo 'EXPERIMENT 1 OF 3: Min Cut Sparse ER, no RR'

./mc_sparse_er_runner_no_rr_mac.sh ../input_graphs/mc_er_inputs/ ../test_results/mc_sparse_er_no_rr_results/ ${host_file} ${max_procs}

#NOTE: This is a new experiment, not as large as experiment 3, but quite large
echo 'EXPERIMENT 2 OF 3: Parallel CC on real world graphs (with RR)'

./7_24_18_pcc_real_graphs.sh ../test_results/pcc_real_results/ ${host_file} ${max_procs}

#NOTE: This stresses our system's memory, most likely will not crash, but there is a risk
echo 'EXPERIMENT 3 OF 3: Parallel CC on 2 large graphs, replicating figure 3 (with RR)'

./pcc_fig_3_replicate.sh ../test_results/pcc_fig_3_results/ ${host_file} ${max_procs}

