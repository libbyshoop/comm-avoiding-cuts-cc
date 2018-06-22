#!/usr/bin/env bash

# Generates a graph with PaRMAT
# Usage: path_to_parmat_executable num_vertices num_edges

#TODO: Maybe, if we want, we could incorporate some of the other optional arguments
#for the PaRMAT call, since it is capable of doing undirected graphs or naming the 
#output file differently, etc., if we use more arguments

# Our path to parmat: ~/builds/PaRMAT/Release/PaRMAT
parmat_path=$1
vertices=$2
edges=$3

set -x

#NOTE: We do not have hash, so if this fails, comment out the following if block

#if we have gsed, then use it, else just use sed (a text editor)
if hash gsed 2> /dev/null; then
	sed=gsed
else
	sed=sed
fi

echo "# RMAT driver ${parmat_path} ${vertices} ${edges} $(date)"
echo ${vertices} ${edges}

#Uses PaRMAT to generate a graph with a certain number of vertices and edges, the
#specified amount of memory usage, and no edges to self or duplicate edges
${parmat_path} -nVertices ${vertices} -nEdges ${edges} -memUsage 0.9 -noEdgeToSelf -noDuplicateEdges 1>&2

#Use sed to adjust the output of the above PaRMAT graph generation call, which is
#stored in out.txt, to work with the code
${sed} -r 's/^([0-9]+)[ \t]*([0-9]+)/\1 \2 1/' out.txt
