
process EGGNOG {
    label "eggnog_mapper_v2"
    tag "$sample_id"
    publishDir "results/eukaryotes/eggnog", mode: 'copy'

    input:
    tuple val(sample_id), path(proteins)

    output:
    path("${sample_id}_eggnog.emapper.*")

    script:
    """
    set -euo pipefail
    # Activate the container's environment for eggNOG-mapper.
    export MAMBA_SKIP_ACTIVATE=""
    source /usr/local/bin/_activate_current_env.sh

    # Use a local temp directory to avoid polluting the work directory.
    mkdir -p tmp

    emapper.py \
    -i ${proteins} \
    --itype proteins \
    -o ${sample_id}_eggnog \
    -m mmseqs \
    --cpu ${task.cpus} \
    --data_dir /eggnog-data \
    --temp_dir ./tmp

    """
}