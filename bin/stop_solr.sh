#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

echo "Stopping Solr"
echo "============="

$SOLR_DIR/bin/solr stop
