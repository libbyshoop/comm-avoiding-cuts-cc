import networkx as nx
import sys, os, datetime

# Author: Katya Gurgel
# Description: A script for cleaning up any graph text files that have node numbers 
#within the edgelist that are higher than the total number of nodes. Although our 
#generators do not create this issue, certain datasets can, especially after reformatting. 
#Note that this script assumes the file is in the standard format with the header 
#line and num nodes num edges line before an edge list. If it is not, use one of 
#the other scripts in this directory or one of your own scripts to clean it up.

# Usage: python ./clean_node_nums.py INPUT_FILE > OUTPUT_DIR/OUTPUT_FILE

file = open(sys.argv[1], mode="r")
lines = file.readlines()


#getting the nodes and number of nodes and edges
nodes = []
numEdges = 0
numNodes = 0
for line in lines[2:]:
	edge = line.split()
	node1 = int(edge[0])
	node2 = int(edge[1])
	numEdges += 1
	if (node1) not in nodes:
		nodes.append(node1)
		numNodes += 1
	if (node2) not in nodes:
		nodes.append(node2)
		numNodes += 1

nodes.sort()

#using the sorted list of nodes, assign them to consecutive numbers, so as to not trigger the assertion error to or from < vertex_count_, where to and from are node numbers
nodeChanges = {}
i = 0
for node in nodes:
	nodeChanges[node] = i
	i += 1

#outputting the new, cleaned graph file with the 2 top lines + all the old edges and weights printed with the updated node numbers
print('# {} {} {}'.format(datetime.datetime.now(), os.popen('git rev-parse HEAD').read().strip(), sys.argv[1]))

print('{0} {1}'.format(str(numNodes), str(numEdges)))

for line in lines[2:]:
	edge = line.split()
	print('{0} {1} {2}'.format(nodeChanges[int(edge[0])], nodeChanges[int(edge[1])], int(edge[2])))

