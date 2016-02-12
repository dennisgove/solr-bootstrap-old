#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

if [ -d "$BASE_DIR/bin/zookeeper" ]; then
  echo "Deleting existing $BASE_DIR/bin/zookeeper"
  rm -rf $BASE_DIR/bin/zookeeper
fi

echo "Extracting zookeeper into $BASE_DIR/bin/zookeeper"
cat $BASE_DIR/dist/zookeeper_* > $BASE_DIR/bin/zookeeper.tar.gz
tar -xf $BASE_DIR/bin/zookeeper.tar.gz -C $BASE_DIR/bin/
rm $BASE_DIR/bin/zookeeper.tar.gz
