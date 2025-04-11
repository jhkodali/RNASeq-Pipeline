### RNA-seq Pipeline

Nextflow pipeline that performs sample quality control, alignment, and quantification utilizing FastQC, STAR, MultiQC, and VERSE and outputs counts data.  

#### Structure

**bin/**
Contains two python scripts
- concat.py: concatanates gene expression counts into one counts matrix
- parse_gtf.py: parses the GTF file and creates a delimited file containing the Ensembl human ID and its corresponding gene name in a text file

**env/**
- base_env.yml: defines conda environment to run Nextflow
- README.md: lists docker containers used for modules

**modules/**
Contains modules for processes
- fastqc
- parse_gtf
- star_index: 
- star_align
- multiqc
- verse
- concat

**refs/**
- c2.cp.v2024.1.Hs.symbols.gmt: canonical pathway gene sets for GSEA
- genes.txt: list of differentially expressed genes for DAVID analysis input

**results/**
- multiqc_report: report of FastQC and STAR alignment statistics for quality control
- counts.csv: counts matrix
- parsed_gtf.txt: list of Ensemble human IDs and corresponding gene symbols

"**project1_notebook.Rmd**" is an R Markdown file that captures the quality of the sequence alignment and walks through downstream analyses: 
- Filtering of the counts
- Differential expression using DESeq2
- DAVID analysis
- Dimensionality reduction using PCA visualized using ggplot2
- Sample-to-sample distance heat map using pheatmap
  

