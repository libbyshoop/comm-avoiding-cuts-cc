#!/usr/bin/env bash
# Script for creating sparse Watts Strogatz graphs for use in our experiments
# Author: Katya Gurgel

#usage: ./sparse_ws_generator.sh OUTPUT_DIR

#our output_dir=../../Testing/mc_ws_inputs

output_dir=$1

graph_sizes=( 200 300 400 600 800 1200 1600 2400 3200 4800)

for size in "${graph_sizes[@]}"; 
do
	k_neighbors=$((${size}/50))

	seed=$RANDOM

	../utils/generate.py 'connected_watts_strogatz_graph(N, K, 0.2)' ${size} -k ${k_neighbors} -s ${seed} > ${output_dir}/ws_${size}_${k_neighbors}.in

	echo "Generated ${size}-vertice Watts-Strogatz graph with k=${k_neighbors}, edge-rewiring probability=0.2"
done
