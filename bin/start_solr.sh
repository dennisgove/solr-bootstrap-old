#!/bin/bash

echo "Starting Solr"
echo "============="

hostname=`hostname`
memory="64g"

if [ "winterfell" = "$hostname" ]
then
  memory="8g"
fi 

bin/solr/bin/solr -cloud -m ${memory} -z localhost:2181 -s data/solr/home $@
