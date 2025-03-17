#!/usr/bin/env nextflow

include { FAST_QC } from './modules/fastqc'
include { STAR_INDEX } from './modules/star_index'
include { PARSE_GTF } from './modules/parse_gtf'
include { STAR_ALIGN } from './modules/star_align'
include { MULTIQC } from './modules/multiqc'
include { VERSE } from './modules/verse'
//include { CONCAT } from './modules/concat'

workflow {

    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    Channel.fromFilePairs(params.reads).transpose()
    | set { fastqc_ch }

    FAST_QC(fastqc_ch)
    STAR_INDEX(params.genome, params.gtf)
    PARSE_GTF(params.gtf)
    STAR_ALIGN(align_ch, STAR_INDEX.out.index)

    FAST_QC.out.collect()
    | set { fastqc_out }

    STAR_ALIGN.out.log.collect()
    | set { star_log }

    fastqc_out.mix(star_log).flatten().collect()
    | set { multiqc_ch }

    MULTIQC(multiqc_ch)

    VERSE(STAR_ALIGN.out.bam, params.gtf)

    VERSE.out.counts.collect()
    | set {concat_ch}

    concat_ch.view()

    //CONCAT(concat_ch)*/
    

    

}
