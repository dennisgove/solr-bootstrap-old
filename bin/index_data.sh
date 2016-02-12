#!/bin/bash

#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if (( $# < 2 )); then
  echo "Expected argments collectionName dataDirectory [data file extension, default='json']"
  exit 1
fi

collection=$1
dataDirectory=$2
extension="${3:-json}"

echo "Indexing $collection"

files=$(ls $dataDirectory/*.${extension})
total="$(echo -e "$(wc -w <<< "$files")" | tr -d '[[:space:]]')"

echo "Iterating through $total files"

itemNumber=1
for file in $files;
do
  echo "==================================================================================================================================="
  echo "($itemNumber of $total) $file"

  echo "$SOLR_DIR/bin/post -p $SOLR_PORT -c $collection -filetypes ${extension} $file"
  $SOLR_DIR/bin/post -p $SOLR_PORT -c $collection -filetypes ${extension} $file

  itemNumber=$((itemNumber+1))
  echo "==================================================================================================================================="
done

# cleanup

