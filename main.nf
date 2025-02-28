#!/usr/bin/env nextflow

include { FAST_QC } from './modules/fastqc'
include { STAR_INDEX } from './modules/star_index'
include { PARSE_GTF } from './modules/parse_gtf'
include { STAR_ALIGN } from './modules/star_align'

workflow {

    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    Channel.fromFilePairs(params.reads).transpose()
    | set { fastqc_ch }

    FAST_QC(fastqc_ch)
    STAR_INDEX(params.genome, params.gtf)
    PARSE_GTF(params.gtf)
    STAR_ALIGN(STAR_INDEX.out, params.reads)
}
