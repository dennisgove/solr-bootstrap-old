#!/bin/bash

echo "Stopping Solr"
echo "=================="

kill -9 `pgrep -fn solr`
