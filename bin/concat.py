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

data_frames = []
# naming each count column by sample name
for file in args.input:
    # extract sample name by slicing file and removing extensions
    sample_name = file.split("/")[-1].replace(".Aligned.out.exon.txt", "") 
    df = pd.read_csv(file, sep="\t").rename(columns={"count": sample_name}) 
    df.set_index("gene", inplace = True)
    data_frames.append(df)

combined_df = pd.concat(data_frames, axis = 1)
combined_df.reset_index(inplace = True)

combined_df.to_csv(args.output, index = False)