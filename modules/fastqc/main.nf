#!/usr/bin/env nextflow

process FAST_QC {

    container "ghcr.io/bf528/fastqc:latest"
    label "process_single"
    publishDir params.outdir

    input:
    tuple val(name), path(fastqc)

    output:
    path("*.zip")

    shell:
    """
    fastqc $fastqc
    """
}