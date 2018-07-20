import networkx as nx
import sys, os, datetime
sys.path.insert(1, os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
from utils import io_utils

# Author: Katya Gurgel
# Description: a script cleaning up unweighted SNAP graphs encoded by pairs of 
# nodes on each line, each representing individual edges. The output is printed.

# Usage: python ./snap_cleanup.py INPUT_FILE > OUTPUT_DIR/OUTPUT_FILE

G = nx.read_edgelist(sys.argv[1])

print('# {} {} {}'.format(datetime.datetime.now(), os.popen('git rev-parse HEAD').read().strip(), sys.argv[1]))

io_utils.print_uw_graph(G)

