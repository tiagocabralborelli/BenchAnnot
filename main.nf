#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { PROKKA } from './modules/prokka.nf'
include { BAKTA } from './modules/bakta.nf'
include { EGGNOG } from './modules/eggnog.nf'
include { PGAP } from './modules/pgap.nf'
workflow {
    fasta_ch = Channel.fromPath('data/*.fna')
    bakta_db_ch = Channel.value(params.bakta_db_dir)
    eggnog_db_ch = Channel.value(params.eggnog_db_dir)
    pgap_dir_ch = Channel.value(params.pgap_dir)

    if (params.bakta_db_dir == null) {
        error "Error: Missing required parameter. Use --bakta_db_dir absolute/path/to/bakta/db on the command line."
    }

    if (params.eggnog_db_dir == null) {
        error "Error: Missing required parameter. Use --eggnog_db_dir absolute/path/to/eggnog/db on the command line."
    }

    if (params.pgap_dir == null) {
        error "Error: Missing required parameter. Use --pgap_dir absolute/path/to/pgap/dir on the command line."
    }

    PROKKA(fasta_ch)
    BAKTA(fasta_ch, bakta_db_ch)
    EGGNOG(fasta_ch, eggnog_db_ch)
    PGAP(fasta_ch, pgap_dir_ch)
}

