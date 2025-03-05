#!/usr/bin/env nextflow

process STAR_ALIGN {

    container "ghcr.io/bf528/star:latest"
    label "process_high"
    publishDir params.outdir, pattern: "*.Log.final.out"
    
    input:
    tuple val(name), path(reads)
    path index

    output:
    path("*.Aligned.out.bam"), emit: bam
    path("*.Log.final.out"), emit: log

    shell:
    """
    STAR --runThreadN $task.cpus --genomeDir $index --readFilesIn $reads --readFilesCommand zcat --outFileNamePrefix ${name}. --outSAMtype BAM Unsorted
    """
}