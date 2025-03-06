process midas_species {
    container "${params.container}"
    input:
        tuple val(sample), path(fastq_1), path(fastq_2)
        path db

    output:
        path "${sample}/*"

    script:
    template "midas_species.sh"
}

process midas_genes {
    container "${params.container}"
    input:
        tuple val(sample), path(fastq_1), path(fastq_2)
        path db

    output:
        path "${sample}/*"

    script:
    template "midas_genes.sh"
}

process midas_snps {
    container "${params.container}"
    input:
        tuple val(sample), path(fastq_1), path(fastq_2)
        path db

    output:
        path "${sample}/*"

    script:
    template "midas_snps.sh"
}


workflow {
    log.info"""
Nextflow Workflow: KneadData (FredHutch/nf-kneaddata)

Usage:
  --samplesheet: CSV with columns sample,fastq_1,fastq_2
  --db: Folder with reference database
  --analysis_mode: species, genes, or snps
  --outdir: Output directory

Optional:
  --container: Software container used (default: ${params.container})
    """

    if(!params.analysis_mode) error "Must provide --analysis_mode"
    if(!params.samplesheet) error "Must provide --samplesheet"
    if(!params.db) error "Must provide --db"
    if(!params.outdir) error "Must provide --outdir"

    // Point to the reference database
    db = file(params.db, checkIfExists: true)

    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map {
            [
                it.sample,
                file(it.fastq_1, checkIfExists: true),
                file(it.fastq_2, checkIfExists: true),
            ]
        }
        .set {inputs}

    if(params.analysis_mode == "species"){
        midas_species(inputs, db)
    }

    if(params.analysis_mode == "genes"){
        midas_genes(inputs, db)
    }

    if(params.analysis_mode == "snps"){
        midas_snps(inputs, db)
    }
    
}