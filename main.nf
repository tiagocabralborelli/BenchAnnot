#!/usr/bin/env nextflow
nextflow.enable.dsl=2
params.input= 'data/*.fna'

include { PROKKA } from './modules/prokka.nf'

workflow {
    fasta_ch = Channel.fromPath(params.input)

    PROKKA(fasta_ch)
}

workflow.onComplete {
    // Do something when the workflow is complete
    println "Workflow completed successfully"
}