#!/usr/bin/env python

import argparse
import pandas as pd

# set up argument parser
parser = argparse.ArgumentParser()

# set up flags 
# nargs = '+' because multiple files
parser.add_argument("-i", "--input", help='text files containing counts', dest="input", required=True, nargs='+')
parser.add_argument("-o", "--output", help='output file to save counts matrix in', dest="output", required=True)

# runs the parser and input the data into the namespace object
args = parser.parse_args()

# read files
data_frames = [pd.read_csv(file, sep="\t", header = None) for file in args.input]

# concatanate dataframes
combined_df = pd.concat(data_frames, ignore_index = True)

# generate counts matrix 
#counts_matrix = combined_df.apply(pd.Series.value_counts, axis = 0).fillna(0)

combined_df.to_csv(args.output)