# Solr Bootstrap

Solr Bootstrap is a simple set of scripts that will help you create a new solr cloud setup. Currently it only supports single node setups, but within that single node you can create as many collections/shards/replicas as you want.

## Bootstrap
```
solr-bootstrap/bin $ ./unpack_zookeeper.sh
Extracting zookeeper into /Users/dgove1/dev/bfs/solr-bootstrap/bin/../bin/zookeeper

solr-bootstrap/bin $ ./unpack_solr.sh
Extracting solr into /Users/dgove1/dev/bfs/solr-bootstrap/bin/../bin/solr
Creating /Users/dgove1/dev/bfs/solr-bootstrap/bin/../data/solr/home/solr.xml

solr-bootstrap/bin $ ./start_zookeeper.sh
Starting Zookeeper
==================
JMX enabled by default
Using config: /Users/dgove1/dev/bfs/solr-bootstrap/bin/zookeeper/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED

solr-bootstrap/bin $ ./start_solr.sh
Starting Solr
=============
Waiting up to 30 seconds to see Solr running on port 12345 [/]
Started Solr server on port 12345 (pid=26647). Happy searching!


solr-bootstrap/bin $ ./create_collection.sh sample 4 2

Connecting to ZooKeeper at localhost:12344 ...
Uploading /Users/dgove1/dev/bfs/solr-bootstrap/bin/../data/solr/conf/sample for config sample to ZooKeeper at localhost:12344

Creating new collection 'sample' using command:
http://localhost:12345/solr/admin/collections?action=CREATE&name=sample&numShards=4&replicationFactor=2&maxShardsPerNode=8&collection.configName=sample

{
  "responseHeader":{
    "status":0,
    "QTime":3753},
  "success":{"":{
      "responseHeader":{
        "status":0,
        "QTime":3531},
      "core":"sample_shard4_replica1"}}}

solr-bootstrap/bin $
```

Now you can navigate to http://localhost:12345/solr/#/~cloud to view your collection. 

## Create a Collection
Use the create_collection.sh script to create a new collection. This assumes that there is a conf directory available at solr-bootstrap/data/solr/conf/<collectionName>. You can see the sample one for an example. The contents in that directory will be uploaded to zookeeper for configuration management. Note that after creating a collection updating that conf directory **will have no impact on the collection**. If you want to edit a conf then you will need to upload that into zookeeper. At the moment there is no script for that but you can always just delete the collection and recreate it.

```
solr-bootstrap/bin $ ./create_collection.sh <collectionName> <numberShards> <numberReplicas>
```

## Delete a Collection
```
solr-bootstrap/bin $ ./delete_collection.sh <collectionName>
```

## Index Data
You can use index_data.sh to easily index data into your collection. This assumes you have a folder with all your data files in it.
```
solr-bootstrap/bin $ ./index_data.sh <collectionName> <dataDirectory> [data file extension, default='json']
```