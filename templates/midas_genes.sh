#!/bin/bash

set -euo pipefail

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
midas run_genes \
    ./ \
    --debug \
    --sample_name "${sample}" \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    --num_cores ${task.cpus} \
    --midasdb_dir DB \
    --aln_speed "${params.aln_speed}" \
    --aln_mode "${params.aln_mode}" \
    --aln_mapid "${params.aln_mapid}" \
    --aln_mapq "${params.aln_mapq}" \
    --aln_readq "${params.aln_readq}" \
    --aln_cov "${params.aln_cov}" \
    --total_depth "${params.total_depth}" \
    --remove_bt2_index

echo "\$(date) Done running MIDAS"
ls -lahtr
