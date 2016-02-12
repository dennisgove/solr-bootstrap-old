#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

echo "Starting Zookeeper"
echo "=================="

mkdir -p $ZOO_DATA_DIR
mkdir -p $ZOO_LOG_DIR

echo "tickTime=2000
dataDir=$ZOO_DATA_DIR
clientPort=$ZOO_PORT" > $ZOO_DIR/conf/zoo.cfg


$ZOO_DIR/bin/zkServer.sh start
