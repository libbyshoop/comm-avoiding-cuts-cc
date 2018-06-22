#!/usr/bin/env bash

#Adjusted for a 10 node cluster of odroid C2

#Description: file for generating many reg graphs with same degree but varying numbers of nodes
#usage: ./small_density_variation.sh degree <path_to_output_dir>
#output: the graph files, placed in specified output directory

#DIR= parent of current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

nodes=( 10000 20000 40000 80000)

degree=$1
output_path=$2

for node in "${nodes[@]}"; do
#random_regular_graph(int degree, int num nodes) NOTE: n*d must be even
	${DIR}/utils/generate.py 'random_regular_graph(K, N)' ${node} -k ${degree} -s 4321 > ${output_path}/regular_${node}_${degree}.in
done

