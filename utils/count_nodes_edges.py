import sys

#Author: Katya Gurgel
#Description: a simple script for checking the number of nodes and edges in a 
#graph (formatted with the header line and numNodes/numEdges line before the edgelist) 
#for debugging

#Usage: ./count_nodes_edges.py INPUT_GRAPH

file = open(sys.argv[1], mode="r")
lines = file.readlines()

nodes = {}
numNodes = 0
numEdges = 0

for line in lines[2:]:
	edge = line.split()
	numEdges += 1
	node1 = int(edge[0])
	node2 = int(edge[1])
	if (node1) not in nodes:
		nodes[node1] = 1
		numNodes += 1
	if (node2) not in nodes:
		nodes[node2] = 1
		numNodes += 1

print("\nexpected number of nodes and edges: " + lines[1])
print("actual number of nodes and edges: " + str(numNodes) + " " + str(numEdges) + "\n")
