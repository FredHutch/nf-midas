#!/bin/bash

set -euo pipefail

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
midas run_snps \
    ./ \
    --debug \
    --sample_name "${sample}" \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    --num_cores ${task.cpus} \
    --midasdb_dir DB \
    --aln_speed "${params.aln_speed}" \
    --aln_mode "${params.aln_mode}" \
    --fragment_length "${params.fragment_length}" \
    --aln_mapid "${params.aln_mapid}" \
    --aln_mapq "${params.aln_mapq}" \
    --aln_readq "${params.aln_readq}" \
    --aln_cov "${params.aln_cov}" \
    --aln_baseq "${params.aln_baseq}" \
    --aln_trim "${params.aln_trim}" \
    --site_depth "${params.site_depth}" \
    --snp_maf "${params.snp_maf}" \
    --remove_bt2_index \
    --analysis_ready \
    --advanced

echo "\$(date) Done running MIDAS"
ls -lahtr
