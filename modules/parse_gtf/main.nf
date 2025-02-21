#!/usr/bin/env nextflow

process PARSE_GTF {
    container "ghcr.io/bf528/biopython:latest"
    label 'process_single'
    publishDir params.outdir, mode: 'copy'
    cache 'lenient'

    input:
    tuple val(name), path(gtf)

    output:
    tuple val(name), path("*.txt")

    script:
    """
    parse_gtf.py -i $gtf -o parsed_gtf.txt
    """

}