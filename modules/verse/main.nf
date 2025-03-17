#!/usr/bin/env nextflow

process VERSE {

    container "ghcr.io/bf528/verse:latest"
    label "process_single"
    publishDir params.outdir, mode: 'copy'

    input:
    path(bam)
    path(gtf)

    output:
    path("${bam.baseName}.exon.txt"), emit: counts
    
    shell:
    """
    verse -S -a $gtf -o $bam.baseName $bam                                                                                                                                                                  
    """

}