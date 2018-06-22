#!/usr/bin/env bash

#Usage: ./cccseq_generator.sh path_to_parmat_executable path_to_output_dir

#current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

parmat=$1
out=$2

sizes=( 128 256 384 512 640 768 896 1024 )

for size in "${sizes[@]}"; do
#rmat_driver.sh parmat_path num_nodes num_edges > output_dir/output_name
	${DIR}/rmat_driver.sh ${parmat} $((size * 1000)) $((size * 1000 * 128)) > $out/rmat_${size}k_128.in
done
