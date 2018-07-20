import networkx as nx
import os
from random import randint

#Description: some helpful functions used by other files for graph generation

#note: sets all weights to the same weight
def set_weights(G, weight):
    for edge in G.edges():  #G.edges_iter():  #removed from networkx 2
        G[edge[0]][edge[1]]['weight'] = weight
    return G

def randomize_weights(G, max):
    for edge in G.edges():  #G.edges_iter():
        G[edge[0]][edge[1]]['weight'] = randint(1, max)
    return G

#Prints graph with edge weights already present
def print_graph(G):
    print('{0} {1}'.format(nx.number_of_nodes(G), nx.number_of_edges(G)))
    for edge in G.edges():  #G.edges_iter():
        print('{0} {1} {2}'.format(edge[0], edge[1], int(G[edge[0]][edge[1]]['weight']))) #edit: needed to cast the weight to int for largest_cc.py

#Function edited by: Katya Gurgel
#Prints a NetworkX graph with all edges being weight 1. Ideal for unweighted graphs from outside datasets that need reformatting.
def print_uw_graph(G):
    print('{0} {1}'.format(nx.number_of_nodes(G), nx.number_of_edges(G)))
    for edge in G.edges():  #G.edges_iter():
        print('{0} {1} {2}'.format(edge[0], edge[1], 1))

def read_stdin():
    first_line = input()
    while first_line.startswith('#'):
        first_line = input()
    n, m = map(int, first_line .split())
    G = nx.Graph()
    G.add_nodes_from(range(0, n))
    for _i in range(0, m):
        u, v, w = map(int, input().split())
        G.add_edge(u, v, weight=w)
    return G
