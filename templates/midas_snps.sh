#!/bin/bash

set -euo pipefail

# Decompress the reference database
mkdir DB/
echo "\$(date) Decompressing ${db} to DB/"
tar -xzvf "${db}" -C DB/

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
run_midas.py snps \
    ./ \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    -t ${task.cpus} \
    -d DB \
    --remove_temp

echo "\$(date) Done running MIDAS"
ls -lahtr

# Clean up the database directory so that those files are not saved
echo "\$(date) Cleaning up temporary database folder"
rm -r DB
