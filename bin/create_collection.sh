#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if [ "$#" -ne 3 ]; then
    echo "Expected argments collectionName numberShards numberReplicas"
    exit 1
fi

collection=$1
numShards=$2
numReplicas=$3

$SOLR_DIR/bin/solr create -c $collection -d $SOLR_CONF_DIR/$collection -n $collection -shards $numShards -replicationFactor $numReplicas
