#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
collection=$1

bin/solr/bin/solr delete -c $collection
