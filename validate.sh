#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
FILES="./instances/*"
for f in $FILES
do
  BASENAME="$(basename -- $f)"
  echo "Validating $f ..."

  ../shacl-1.3.2/bin/shaclvalidate.sh -datafile instances/gdp_sunshine-maDMP.ttl -shapesfile maDMP-1-1.SHACL-schema.ttl > "./validation_results/$BASENAME-result.ttl"

  if [ $? -eq 0 ]; then
    echo "  Validation passed!"
  else
    echo "  Validation failed! Check the output file for more info."
  fi
done