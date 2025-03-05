#!/usr/bin/env nextflow

include { FAST_QC } from './modules/fastqc'
include { STAR_INDEX } from './modules/star_index'
include { PARSE_GTF } from './modules/parse_gtf'
include { STAR_ALIGN } from './modules/star_align'
include { MULTIQC } from './modules/multiqc'


workflow {

    Channel.fromFilePairs(params.reads)
    | set { align_ch }

    Channel.fromFilePairs(params.reads).transpose()
    | set { fastqc_ch }

    FAST_QC(fastqc_ch)
    STAR_INDEX(params.genome, params.gtf)
    PARSE_GTF(params.gtf)
    STAR_ALIGN(align_ch, STAR_INDEX.out.index)

    FAST_QC.out.map{ it[1] }.collect()
    | set { fastqc_out }

    STAR_ALIGN.out.log.map{ it[1] }.collect()
    | set { star_log }

    fastqc_out.mix(star_log).flatten().collect()
    | set { multiqc_ch }

    MULTIQC(multiqc_ch)
    
    

}
