#!/usr/bin/env nextflow

process CONCAT {
    container "ghcr.io/bf528/pandas:latest"
    label 'process_single'
    publishDir params.outdir, mode: 'copy'
    cache 'lenient'

    input:
    path(txt)

    output:
    path("*.csv")

    script:
    """
    concat.py -i $txt -o counts.csv
    """

}