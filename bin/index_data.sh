#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
collection=$1
extension="json"

echo "Indexing $collection - working in directory $scriptDir"

files=$(ls raw_data/${collection}/*.${extension})
total="$(echo -e "$(wc -w <<< "$files")" | tr -d '[[:space:]]')"

echo "Iterating through $total files"

itemNumber=1
for file in $files;
do
  echo "==================================================================================================================================="
  echo "($itemNumber of $total) $file"

  echo "$scriptDir/bin/solr/bin/post -c $collection -filetypes ${extension} $file"
  $scriptDir/bin/solr/bin/post -c $collection -filetypes ${extension} $file

  itemNumber=$((itemNumber+1))
  echo "==================================================================================================================================="
done

# cleanup

