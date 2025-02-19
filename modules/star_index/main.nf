#!/usr/bin/env nextflow


process STAR_INDEX {

    container "ghcr.io/bf428/star:latest"
    label "process_high"

    input:
    path genome
    path gtf

    output:
    path "star", emit: STAR_INDEX
    
    shell:
    """
    mkdir star
    STAR --runThreadN $task.cpus --runMode genomeGenerate --genomeDir star --genomeFastaFiles $genome --sjdbGTFfile $gtf
    """

}