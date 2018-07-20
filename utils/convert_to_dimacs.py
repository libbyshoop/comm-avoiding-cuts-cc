import sys

# Author: Katya Gurgel
# Description: A script for converting our current format (header comment + a 
#line with num nodes num edges followed by edge list w/ weights) into the DIMACS 
#format used by another paper

# Usage: python ./convert_to_dimacs INPUT_FILE HEADER_COMMENT > OUTPUT_DIR/OUTPUT_FILE

file = open(sys.argv[1], mode="r")
lines = file.readlines()

#formatting the comment and problem lines to match DIMACS
print("c " + sys.argv[2])
print("p cut " + lines[1].rstrip())

for line in lines[2:]:
	print("a " + line.rstrip())

