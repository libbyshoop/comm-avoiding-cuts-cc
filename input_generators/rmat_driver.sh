#!/usr/bin/env bash

# Generates a graph with PaRMAT
# Usage: ./rmat_driver.sh vertices edges > output_dir/graphname.in

#NOTE: This script will generate an out.txt each time it is run

#TODO: Maybe, if we want, we could incorporate some of the other optional arguments
#for the PaRMAT call, since it is capable of doing undirected graphs or naming the 
#output file differently, etc., if we use more arguments

#parmat_path=$1		# Change made 7/23/18: removed the parmat path as a parameter; made PaRMAT globally available
vertices=$1
edges=$2

set -x

#NOTE: We do not have hash, so if this fails, comment out the following if block

#if we have gsed, then use it, else just use sed (a text editor)
if hash gsed 2> /dev/null; then
	sed=gsed
else
	sed=sed
fi

echo "# RMAT driver PaRMAT ${vertices} ${edges} $(date)"
echo ${vertices} ${edges}

#Uses PaRMAT to generate a graph with a certain number of vertices and edges, the
#specified amount of memory usage, and no edges to self or duplicate edges
PaRMAT -nVertices ${vertices} -nEdges ${edges} -memUsage 0.9 -noEdgeToSelf -noDuplicateEdges 1>&2

#Use sed to adjust the output of the above PaRMAT graph generation call, which is
#stored in out.txt, to work with the code
${sed} -r 's/^([0-9]+)[ \t]*([0-9]+)/\1 \2 1/' out.txt

