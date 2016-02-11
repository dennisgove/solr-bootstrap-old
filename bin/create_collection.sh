#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
collection=$1
numShards=$2
numReplicas=$3

bin/solr/bin/solr create -c $collection -d data/solr/conf/$collection -n $collection -shards $numShards -replicationFactor $numReplicas
