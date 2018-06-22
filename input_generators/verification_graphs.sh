#!/usr/bin/env bash
#Create graphs for verifying the algorithms' accuracy.
#They have known min cuts and connected components.

#usage: ./verification_graphs.sh <path_to_output_dir>

#Gives us the parent directory of the script 
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."

vertices=10

#https://networkx.github.io/documentation/stable/reference/generators.html
#See this link for explanations of the different types of graph generators



#barbell_graph(num nodes in complete graphs, num nodes in path)
${DIR}/utils/generate.py 'barbell_graph(N // 2, N // 2)' ${vertices} > $1/barbell.in

#grid_2d_graph(num nodes horizontal, num nodes vertical)
${DIR}/utils/generate.py 'grid_2d_graph(N // 2, N // 3)' ${vertices} > $1/grid.in

#lollipop_graph(num nodes in complete graph, num nodes in path)
${DIR}/utils/generate.py 'lollipop_graph(N // 2, N // 2)' ${vertices} > $1/lolli.in

#star_graph(num-1 of the total nodes)    note: node 0 in center, n around it
${DIR}/utils/generate.py 'star_graph(N)' ${vertices} > $1/star.in

#wheel_graph(num-1 of the total nodes)    note: node 0 in center, n around it
${DIR}/utils/generate.py 'wheel_graph(N)' ${vertices} > $1/wheel.in

#connected_watts_strogatz_graph(num of nodes, each node is joined with k nearest
#neighbors in a ring topology, probability of rewiring each edge)   
#note: makes a cws small world graph
${DIR}/utils/generate.py 'connected_watts_strogatz_graph(N, K, 0.0)' ${vertices} -k 4 > $1/ws.in

#connected_caveman_graph(number of cliques, size of cliques)
${DIR}/utils/generate.py 'connected_caveman_graph(3, 4)' ${vertices} > $1/caveman.in



## RESULTS -------------------------------
# barbell: 		cc = 1		cut = 100
# grid:			cc = 1		cut = 200
# lollipop:		cc = 1		cut = 100
# star 			cc = 1		cut = 100
# wheel 		cc = 1		cut = 300
# cws			cc = 1		cut = 400
# caveman: 		cc = 1		cut = 200

# note: default weight = 100

