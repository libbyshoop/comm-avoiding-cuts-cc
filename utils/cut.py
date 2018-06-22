#!/usr/bin/env python3

#Computes the mincut of the graph
#Usage: ./utils/generate.py 'cycle_graph(N)' 100 | ./utils/cut.py
# or cat mygraph.in | ./cut.py
# or ./cut.py < mygraph.in
#Output: weight of the min cut, [array of nodes in one side of partition], [array
#of nodes in other side of partition]

import networkx as nx
import sys, os
sys.path.insert(1, os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
from utils import io_utils

print(nx.stoer_wagner(io_utils.read_stdin()))


