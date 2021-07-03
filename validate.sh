#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
FILES="./instances/*"
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  #cat "$f"
  BASENAME="$(basename -- $f)"
  ../shacl-1.3.2/bin/shaclvalidate.sh -datafile ./instances/gdp_sunshine-maDMP.ttl -shapesfile maDMP-1-1.SHACL-schema.ttl > "./validation_results/$BASENAME-result.ttl"
done