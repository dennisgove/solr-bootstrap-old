#!/bin/bash

. $(dirname $(readlink -f $BASH_SOURCE[0]))/env.sh

echo "Stopping Zookeeper"
echo "=================="

$ZOO_DIR/bin/zkServer.sh stop
