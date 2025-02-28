#!/usr/bin/env nextflow

process STAR_ALIGN {

    container "ghcr.io/bf528/star:latest"
    label "process_high"

    input:
    path genomeDir
    path reads

    output:
    path "*.bam", emit: bam_file
    path "*.Log.final.out", emit: log_file

    shell:
    """
    STAR --runThreadN $task.cpus --genomeDir $genomeDir --readFilesIn $reads --readFilesCommand zcat --outFileNamePrefix "aligned" --outSAMtype BAM SortedByCoordinate
    """
}