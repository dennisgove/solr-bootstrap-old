#!/bin/bash

scriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
collection=$1

echo "Deleting all data in $collection"

echo "<delete><query>*:*</query></delete>" | bin/solr/bin/post -c $collection -d
