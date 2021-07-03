#!/bin/bash
# NOTE : Quote it else use array to avoid problems #
FILES="./instances/turtle/*"
GREEN=$'\e[0;32m'
RED=$'\e[0;31m'
NC=$'\e[0m'
for f in $FILES
do
  BASENAME="$(basename -- $f)"
  echo "Validating $f ..."

  ../shacl-1.3.2/bin/shaclvalidate.sh -datafile "$f" -shapesfile maDMP-1-1.SHACL-schema.ttl > "./validation_results/shacl/$BASENAME-result.ttl"

  if [ $? -eq 0 ]; then
    echo "${GREEN}  Validation passed! ${NC}"
  else
    echo "${RED}  Validation failed! Check the apropriate output file for more info. ${NC}"
  fi
done