#!/usr/bin/env bash

export BIN_DIR=$(dirname $(readlink -f $BASH_SOURCE[0]))
export BASE_DIR=$BIN_DIR/..
export DIST_DIR=$BASE_DIR/dist
export EPHEMERAL_DIR=$BASE_DIR/ephemeral

export DATA_DIR=$BASE_DIR/data
export LOG_DIR=$BASE_DIR/logs

export ZK_DIR=$BIN_DIR/zookeeper
export ZK_PORT=8183
export ZOO_LOG_DIR=$LOG_DIR/zk
export ZOO_CFG=$DIST_DIR/zoo.cfg

export SOLR_DIR=$BIN_DIR/solr
export SOLR_VERSION=6.0.0-SNAPSHOT

MY_IP=$(host $(hostname) | awk '{print $4 }')
