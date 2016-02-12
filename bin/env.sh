#!/usr/bin/env bash

export BIN_DIR=$(dirname $(readlink -f $BASH_SOURCE[0]))
export BASE_DIR=$BIN_DIR/..
export DIST_DIR=$BASE_DIR/dist

export DATA_DIR=$BASE_DIR/data
export LOG_DIR=$BASE_DIR/logs


#####################################################################
# Zookeeper specific items
export ZOO_DIR=$BIN_DIR/zookeeper
export ZOO_PORT=12344
export ZOO_LOG_DIR=$LOG_DIR/zookeeper
export ZOO_DATA_DIR=$DATA_DIR/zookeeper

#####################################################################
# Solr specific items
export SOLR_DIR=$BIN_DIR/solr
export SOLR_VERSION=6.0.0-SNAPSHOT
export SOLR_PORT=12345
export SOLR_LOG_DIR=$LOG_DIR/solr
export SOLR_LOGS_DIR=$SOLR_LOG_DIR
export SOLR_DATA_DIR=$DATA_DIR/solr
export SOLR_CONF_DIR=$SOLR_DATA_DIR/conf

#####################################################################
MY_IP=$(host $(hostname) | awk '{print $4 }')
