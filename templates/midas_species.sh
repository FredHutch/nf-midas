#!/bin/bash

set -euo pipefail

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
mkdir "${sample}"
midas run_species \
    "${sample}" \
    --debug \
    --sample_name "${sample}" \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    --num_cores ${task.cpus} \
    --midasdb_dir DB \
    --word_size "${params.word_size}" \
    --aln_cov "${params.aln_cov}"

echo "\$(date) Done running MIDAS"
ls -lahtr
