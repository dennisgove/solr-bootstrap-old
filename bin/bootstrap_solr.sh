#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if [ -d "$BASE_DIR/bin/solr" ]; then
  echo "Deleting existing $BASE_DIR/bin/solr"
  rm -rf $BASE_DIR/bin/solr
fi

echo "Extracting solr into $BASE_DIR/bin/solr"
cat $BASE_DIR/dist/solr_* > $BASE_DIR/bin/solr.tar.gz
tar -xf $BASE_DIR/bin/solr.tar.gz -C $BASE_DIR/bin/
rm $BASE_DIR/bin/solr.tar.gz
mv $BASE_DIR/bin/solr-$SOLR_VERSION $BASE_DIR/bin/solr
