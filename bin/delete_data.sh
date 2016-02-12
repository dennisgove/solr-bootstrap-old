#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if [ "$#" -ne 1 ]; then
    echo "Expected argments collectionName"
    exit 1
fi

collection=$1

echo "Deleting all data in $collection"
echo "<delete><query>*:*</query></delete>" | $SOLR_DIR/bin/post -p $SOLR_PORT -c $collection -d
