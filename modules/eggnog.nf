#!/usr/bin/env nextflow

process EGGNOG {
    label "eggnog_mapper_v2"
    container "brunoholiva/eggnog_v2:2.1.13-sse41"
    publishDir "results/eggnog", mode: "copy"

    input:
    path fasta_file
    path eggnog_db_dir

    output:
    path "${fasta_file.baseName}_eggnog"

    script:
    """
    export MAMBA_SKIP_ACTIVATE=""
    source /usr/local/bin/_activate_current_env.sh
    mkdir ${fasta_file.baseName}_eggnog
    emapper.py \
    --itype genome \
    --genepred prodigal \
    -i ${fasta_file} \
    -o ${fasta_file.baseName} \
    --data_dir ${eggnog_db_dir} \
    -m mmseqs \
    --cpu ${task.cpus} \
    --output_dir ${fasta_file.baseName}_eggnog
    """
}