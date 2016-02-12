#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

echo "Starting Solr"
echo "============="

hostname=`hostname`
memory="64g"

if [ "winterfell" = "$hostname" ]
then
  memory="8g"
fi 

mkdir -p $SOLR_DATA_DIR/home
mkdir -p $SOLR_LOG_DIR

$SOLR_DIR/bin/solr -cloud -m ${memory} -p $SOLR_PORT -z localhost:$ZOO_PORT -s $SOLR_DATA_DIR/home $@
