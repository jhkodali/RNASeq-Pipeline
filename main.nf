#!/usr/bin/env nextflow

include { FAST_QC } from './module/fastqc'
include { STAR_INDEX } from './modules/star_index'

workflow {

    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    Channel.fromFilePairs(params.reads).transpose()
    | set { fastqc_ch }

    FASTQC(fastqc_ch)
    STAR_INDEX(params.genome, params.gtf)
}
