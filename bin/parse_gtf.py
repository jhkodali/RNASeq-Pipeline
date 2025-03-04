#!/usr/bin/env python

import argparse

# initializing the argparse object that we will modify
parser = argparse.ArgumentParser()

# we are asking argparse to require a -i or --input flag on the command line when this
# script is invoked. It will store it in the "filenames" attribute of the object
# we will be passing it via command line

parser.add_argument("-i", "--input", help='GTF file containing genomic annotations', dest="input", required=True)
parser.add_argument("-o", "--output", help='The output file where we will write Ensembl Gene IDs and Gene Names', dest="output", required=True)

# runs the parser and input the data into the namespace object
args = parser.parse_args()

with open(args.input, 'r') as gtf:
    with open(args.output, 'w') as output:
        output.write("Ensembl_Gene_ID\tGene_Name\n")
        
        for line in gtf:
            if line.startswith("#"):
                continue
            
            columns = line.strip().split('\t')
            
            if columns[2] == 'gene':
                attributes = columns[8]
                
                ensembl_gene_id = None
                gene_name = None
                
                for attribute in attributes.split(';'):
                    if "gene_id" in attribute:
                        ensembl_gene_id = attribute.split('"')[1]
                    elif "gene_name" in attribute:
                        gene_name = attribute.split('"')[1]
                
                if ensembl_gene_id and gene_name:
                    output.write(f"{ensembl_gene_id}\t{gene_name}\n")

print(f"Ensembl Gene IDs and Gene Names written to {args.output}")
