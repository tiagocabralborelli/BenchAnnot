#!/usr/bin/env nextflow

process prokka {
    label 'prokka'
    container 'staphb/prokka:1.14.6'

    input:
    path fasta_file

    output:
    path "${fasta_file.baseName}_prokka" // each prokka output directory is named after the fasta file

    publishDir "results/prokka/${fasta_file.baseName}", mode: 'symlink' 

    script: 
    """
    PROKKA --outdir ${fasta_file.baseName}_prokka --prefix ${fasta_file.baseName} ${fasta_file}
    """
}

