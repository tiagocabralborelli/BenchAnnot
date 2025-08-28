# Functional Annotation Pipeline

This pipeline is designed to test and compare multiple functional annotation tools

## Requirements

- [Nextflow](https://www.nextflow.io/)
- [Docker](https://www.docker.com/)
- Input genome files in FASTA format (`.fna`) placed in the `data/` directory

## Usage
Place your genome files in the `data/` folder.
Run the pipeline with:
    ```bash
    nextflow run main.nf
The pipeline will automatically execute all modules defined in the workflow.

## Output

- Annotated results for each genome will be found in `results/prokka/<sample>_prokka/`, where `<sample>` is the base name of your input file.

## Module

- Prokka: defined in `modules/prokka.nf` and automatically handles each input genome.

# Notes
- Pipeline for reproducibility and scalability using Docker containers.
- All intermediate files are stored in the `work/` directory and final results are organized under  `results/`.