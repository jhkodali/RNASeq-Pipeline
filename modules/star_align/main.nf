#!/usr/bin/env nextflow

process STAR_ALIGN {

    container "ghcr.io/bf528/star:latest"
    label "process_high"

    input:
    path genomeDir
    path reads

    output:
    path "", emit: 

    shell:
    """
    STAR --runThreadN $task.cpus --genomeDir star --readFilesIn, --readFilesCommand, --outFileNamePrefix, --outSAMtype
    """
}