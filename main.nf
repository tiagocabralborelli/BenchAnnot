#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Module imports
include { GFFREAD      } from './modules/gffread.nf'
include { KOFAMSCAN    } from './modules/KofamScan.nf'
include { INTERPROSCAN } from './modules/interproscan.nf'
include { EGGNOG       } from './modules/eggnog.nf'

// Pair each genome FASTA with its corresponding GFF annotation.
Channel
  .fromPath('$projectDir/data/eukaryotes/*.fna')
  .map { fa ->
    def id = fa.baseName
    def ann = file("data/eukaryotes/${id}.gff")
    tuple(id, fa, ann)
  }
  .filter { id, fa, ann -> ann.exists() }
  .set { genome_pairs }

// KofamScan database inputs.
profiles = Channel.fromPath('$projectDir/data/eukaryotes/db/kofamscan/profiles/*', checkIfExists: true)
ko_list = Channel.fromPath('$projectDir/data/eukaryotes/db/kofamscan/ko_list', checkIfExists: true)

workflow eukaryotes_annot {
  // 1) Build protein sequences from genome + GFF.
    proteins = GFFREAD(genome_pairs)

  // 2) Functional annotation modules.
    INTERPROSCAN(proteins)
    KOFAMSCAN(proteins, profiles, ko_list)
    EGGNOG(proteins)
}

workflow.onComplete { println "Workflow completed successfully!" }

