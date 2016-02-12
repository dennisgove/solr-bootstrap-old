# Solr Bootstrap

Solr Bootstrap is a simple set of scripts that will help you create a new solr cloud setup. Currently it only supports single node setups, but within that single node you can create as many collections/shards/replicas as you want.

## Bootstrap
```
solr-bootstrap/bin $ ./unpack_zookeeper.sh
solr-bootstrap/bin $ ./unpack_solr.sh
solr-bootstrap/bin $ ./start_zookeeper.sh
solr-bootstrap/bin $ ./start_solr.sh
solr-bootstrap/bin $ ./create_collection.sh sample 4 2
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

## Environment Variables
You can edit anything in solr-bootstrap/bin/env.sh to change various settings (like the ports used by solr and zookeeper)