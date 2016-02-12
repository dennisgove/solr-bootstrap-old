#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if [ "$#" -ne 1 ]; then
    echo "Expected argments collectionName"
    exit 1
fi

collection=$1

$SOLR_DIR/bin/solr delete -c $collection
