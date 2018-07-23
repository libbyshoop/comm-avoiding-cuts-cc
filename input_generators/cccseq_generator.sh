#!/usr/bin/env bash

#Usage: ./cccseq_generator.sh path_to_output_dir

#current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#parmat_path=$1		# Change made 7/23/18: removed the parmat path as a parameter; made PaRMAT globally available
out=$1

sizes=( 128 256 384 512 640 768 896 1024 )

for size in "${sizes[@]}"; do
#rmat_driver.sh num_nodes num_edges > output_dir/output_name
	${DIR}/rmat_driver.sh $((size * 1000)) $((size * 1000 * 128)) > $out/rmat_${size}k_128.in
done

