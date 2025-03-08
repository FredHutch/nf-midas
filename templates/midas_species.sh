#!/bin/bash

set -euo pipefail

# Decompress the reference database
mkdir DB/
echo "\$(date) Decompressing ${db} to DB/"
gunzip -c "${db}" | tar -xvf - -C DB/

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
mkdir "${sample}"
midas run_species \
    "${sample}" \
    --sample_name "${sample}" \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    --num_cores ${task.cpus} \
    --midasdb_dir DB \
    --word_size "${params.word_size}" \
    --aln_cov "${params.aln_cov}"

echo "\$(date) Done running MIDAS"
ls -lahtr

# Clean up the database directory so that those files are not saved
echo "\$(date) Cleaning up temporary database folder"
rm -r DB
