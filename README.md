# BenchAnnot

A Nextflow pipeline to run genome annotation on FASTA assemblies.

## Purpose

- Orchestrate annotation tools and produce reproducible results for benchmarking and downstream analysis.

## Inputs

- Put FASTA files (`.fna`) in the `data/` directory.

## Outputs

- Per-sample annotation directories under `results/module/sample_module/`, where `module` is the tool used and `sample` is the genome used.

## Requirements

- Nextflow 25.04.7 build 5955
- Singularity/Apptainer 1.3.1-1.el7
- Specific databases

## Modules

- `modules/prokka.nf` — Prokka 1.14.6 ([GitHub](https://github.com/tseemann/prokka))
- `modules/bakta.nf` — Bakta 1.11.3 ([GitHub](https://github.com/oschwengers/bakta))
- `modules/eggnog.nf` — eggnog-mapper-v2 2.1.13 ([GitHub](https://github.com/eggnogdb/eggnog-mapper))
- `modules/pgap.nf`— Prokaryotic Genome Annotation Pipeline 2025-05-06.build7983 ([GitHub](https://github.com/ncbi/pgap))

## Parameters

Some modules require specific directories to be provided as parameters:

- **Bakta**: Requires Bakta database version 6.  
  Download from [Zenodo](https://zenodo.org/records/14916843), extract, and provide the absolute path using:  
  
  `--bakta_db_dir /absolute/path/to/bakta/db`

- **EggNog Mapper**: Requires EggNog database files.  
  Download both `mmseqs.tar.gz` and `eggnog.db.gz` from [EggNog](http://eggnog6.embl.de/download/emapperdb-5.0.2/) (as recommended for genome assemblies), extract, and provide the absolute path using:  
  
  `--eggnog_db_dir /absolute/path/to/eggnog/db`

- **PGAP**: Requires a local PGAP installation (including its databases and container images). Follow the official Quick Start to install PGAP and download required data: https://github.com/ncbi/pgap/wiki/Quick-Start. Once installed, provide the absolute installation path with:
 
  `--pgap_dir /absolute/path/to/pgap`

**Run command:**
```
nextflow run main.nf --bakta_db_dir /absolute/path/to/bakta/db --eggnog_db_dir /absolute/path/to/eggnog/db --pgap_dir /absolute/path/to/pgap
```