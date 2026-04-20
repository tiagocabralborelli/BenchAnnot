# Functional Annotation Pipeline

This pipeline orchestrates multiple functional annotation tools for eukaryotic genomes using Nextflow DSL2. It is designed for reproducible, scalable benchmarking and downstream analysis.

## Purpose
- Run multiple annotation tools on the same input genomes.
- Produce consistent outputs for comparison and integration.

## Inputs
Place your data under:
`data/eukaryotes/`

Required files:
- Genome FASTA files: `data/eukaryotes/*.fna`
- Matching GFF files: `data/eukaryotes/<sample>.gff`

The pipeline pairs FASTA and GFF files by basename.

## Outputs
- Final results: `results/eukaryotes/`
- Intermediate files: `work/`

## Requirements
- [Nextflow](https://www.nextflow.io/)
- [Docker](https://www.docker.com/) or [Apptainer](https://apptainer.org/)
- Databases downloaded locally for InterProScan, KofamScan, and eggNOG-mapper

## Modules
- GFFREAD (modules/gffread.nf)
    - Extracts proteins from genome + GFF.
    - Results: `results/eukaryotes/gffread/`
- InterProScan (modules/interproscan.nf)
    - Functional domain and GO/pathway annotations.
    - Results: `results/eukaryotes/interproscan/`
- KofamScan (modules/KofamScan.nf)
    - KEGG Ortholog (KO) assignments.
    - Results: `results/eukaryotes/kofamscan/`
- eggNOG-mapper (modules/eggnog.nf)
    - Orthology-based functional annotation.
    - Results: `results/eukaryotes/eggnog/`

## Parameters
Set database locations in [nextflow.config](nextflow.config):
- `params.ips_data_dir` for InterProScan data
- `params.emapper_data_dir` for eggNOG data

KofamScan databases should be placed under:
`data/eukaryotes/db/kofamscan/`

## Run
```bash
nextflow run main.nf -entry eukaryotes_annot
```

## Documentation
- eggNOG-mapper: [docs/egg.md](docs/egg.md)
- InterProScan: [docs/interproscan.md](docs/interproscan.md)
- KofamScan: [docs/KofamScan.md](docs/KofamScan.md)

## Notes
- The pipeline uses container images for reproducibility.
- Add new tools by creating a module and wiring it into the workflow.