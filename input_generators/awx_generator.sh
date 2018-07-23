#!/usr/bin/env bash

#Usage: ./awx_generator.sh path_to_output_dir

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#parmat_path=$1		# Change made 7/23/18: removed the parmat path as a parameter; made PaRMAT globally available
out=$1

inputs=( 256 512 768 1024 1280 1536 1792 2048 )

for degree in "${inputs[@]}"; do
	${DIR}/rmat_driver.sh 16000 $((16000 * $degree)) > $out/rmat_16k_${degree}.in
done

