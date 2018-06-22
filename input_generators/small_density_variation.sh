#!/usr/bin/env bash

#Adjusted for a 10 node cluster of odroid C2

#Description: file for generating many reg graphs with same number of nodes but 
#varying degree
#usage: ./small_density_variation.sh num_nodes <path_to_output_dir>
#output: the graph files, placed in specified output directory

#DIR= parent of current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

#degrees=( 16 32 64 128 256 512 1024 2048)
degrees=(  20 40 80 120 160)

nodes=$1
output_path=$2

for degree in "${degrees[@]}"; do
#random_regular_graph(int degree, int num nodes) NOTE: n*d must be even
	${DIR}/utils/generate.py 'random_regular_graph(K, N)' ${nodes} -k ${degree} -s 4321 > ${output_path}/regular_${nodes}_${degree}.in
done
