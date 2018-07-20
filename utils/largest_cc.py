import networkx as nx
import sys, os, datetime
sys.path.insert(1, os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
from utils import io_utils

# Author: Katya Gurgel
# Description: a script for taking a graph of our standard format, the header comment,
# num nodes and edges line, and then a weighted edge list, and then takes that graph
# and returns the largest connected component. This is useful because a disconnected 
# graph will not be accepted by the square_root algorithm, and some datasets may
# have outliers.

# Usage: python ./snap_cleanup.py INPUT_FILE > OUTPUT_DIR/OUTPUT_FILE

file = open(sys.argv[1], mode="r")
lines = file.readlines()

G = nx.read_weighted_edgelist(lines[2:])

LCC = max(nx.connected_component_subgraphs(G), key=len)

print('# {} {} {}'.format(datetime.datetime.now(), os.popen('git rev-parse HEAD').read().strip(), sys.argv[1]))

io_utils.print_graph(LCC)

