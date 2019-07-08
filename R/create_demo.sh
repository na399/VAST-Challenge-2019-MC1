#!/bin/bash

mkdir out/demo

awk -F "," 'NR==1 {print; next} {if ($1 < 5 && (/2020-04-08/ || /2020-04-09/)) print;}' out/mc1-reports-data-aggregated.csv >out/demo/mc1-reports-data-aggregated.csv

awk -F "," 'NR==1 {print; next} {if ($2 < 5 && (/2020-04-08/ || /2020-04-09/)) print;}' out/all_summary_processed.csv >out/demo/all_summary_processed.csv

awk -F "," 'NR==1 {print; next} {if ($1 < 5 && (/2020-04-08/ || /2020-04-09/)) print;}' out/all_summary_aggregated.csv >out/demo/all_summary_aggregated.csv
