#!/bin/bash

set -euo pipefail

# Run the MIDAS command
# Output to the current working directory
echo "\$(date) Running MIDAS"
midas run_snps \
    ./ \
    -1 "${fastq_1}" \
    -2 "${fastq_2}" \
    -t ${task.cpus} \
    -d DB \
    --remove_temp

echo "\$(date) Done running MIDAS"
ls -lahtr
