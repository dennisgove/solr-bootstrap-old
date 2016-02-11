#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

echo "Starting Zookeeper"
echo "=================="

mkdir -p $EPHEMERAL_DIR

echo "tickTime=2000
dataDir=$DATA_DIR/zk
clientPort=$ZK_PORT" > $ZOO_CFG


$ZK_DIR/bin/zkServer.sh start
