#!/bin/python

import os
import shutil
import json
import urllib
import tarfile
import subprocess
import sys

def getConfiguration(path):
  with open(path) as f:
    return json.load(f)

def download(url, toPath):
  # dlProgress gotten from http://stackoverflow.com/questions/51212/how-to-write-a-download-progress-indicator-in-python
  def dlProgress(count, blockSize, totalSize):
    percent = int(count*blockSize*100/totalSize)
    sys.stdout.write("\rDownloading " + url + "...%d%%" % percent)
    sys.stdout.flush()

  urllib.urlretrieve(url, filename=toPath, reporthook=dlProgress)
  print

def extract(sourceFile, destinationPath):
  with tarfile.open(sourceFile) as t:
    t.extractall(path=destinationPath)

def createDirectory(path):
  if not os.path.exists(path):
    os.makedirs(path)

def installSolr(configuration):
  print "Installing Solr to %s/bin/solr" % (configuration["installDirectory"])
  
  # create install directories
  createDirectory("%s" % (configuration["installDirectory"]))
  createDirectory("%s/packages" % (configuration["installDirectory"]))
  createDirectory("%s/bin" % (configuration["installDirectory"]))

  # download solr
  download(configuration["solrUrl"], "%s/packages/solr.tgz" % (configuration["installDirectory"]))

  # unpack solr
  extract("%s/packages/solr.tgz" % (configuration["installDirectory"]), "%s/bin" % (configuration["installDirectory"]))
  extractionDir = determineExtractionDirectory("%s/packages/solr.tgz" % (configuration["installDirectory"]))
  shutil.move("%s/bin/%s" % (configuration["installDirectory"], extractionDir), "%s/bin/solr" % (configuration["installDirectory"]))

def determineExtractionDirectory(path):
  with tarfile.open(path) as t:
    temp = {}
    extractionDir = t.getmembers()[0].name.split("/")[0]
    return extractionDir

def installZookeeper(configuration):
  print "Installing Zookeeper to %s/bin/zookeeper" % (configuration["installDirectory"])
  
  # create install directories
  createDirectory("%s" % (configuration["installDirectory"]))
  createDirectory("%s/packages" % (configuration["installDirectory"]))
  createDirectory("%s/bin" % (configuration["installDirectory"]))

  # download zookeeper
  download(configuration["zookeeperUrl"], "%s/packages/zookeeper.tgz" % (configuration["installDirectory"]))

  # unpack zookeeper
  extract("%s/packages/zookeeper.tgz" % (configuration["installDirectory"]), "%s/bin" % (configuration["installDirectory"]))
  extractionDir = determineExtractionDirectory("%s/packages/zookeeper.tgz" % (configuration["installDirectory"]))
  shutil.move("%s/bin/%s" % (configuration["installDirectory"], extractionDir), "%s/bin/zookeeper" % (configuration["installDirectory"]))

def startZookeeper(configuration):

  # create base data/conf directory
  createDirectory("%s/data/zookeeper" % (configuration["installDirectory"]))
  createDirectory("%s/log/zookeeper" % (configuration["installDirectory"]))

  for port in configuration["zookeeperPorts"]:
    print "Starting zookeeper on port %d" % port

    # create required items
    dataDirectory = "%s/data/zookeeper/instance-%d" % (configuration["installDirectory"], port)
    logDirectory = "%s/log/zookeeper/instance-%d" % (configuration["installDirectory"], port)
    configurationFile = "%s/data/zookeeper/instance-%d.cfg" % (configuration["installDirectory"], port)

    createDirectory(logDirectory)
    createDirectory(dataDirectory)
    createZookeeperConfigurationFile(configurationFile, dataDirectory, port)

    # actually start zookeeper
    arguments = [
      "ZOOCFGDIR=%s/data/zookeeper" % (configuration["installDirectory"]),
      "ZOOCFG=instance-%d.cfg" % (port),
      "ZOO_LOG_DIR=%s" % (logDirectory),
      "%s/bin/zookeeper/bin/zkServer.sh" % (configuration["installDirectory"]),
      "start"
    ]
    os.system(" ".join(arguments))

def stopZookeeper(configuration):
  
  for port in configuration["zookeeperPorts"]:
    configurationFile = "%s/data/zookeeper/instance-%d.cfg" % (configuration["installDirectory"], port)

    if os.path.exists(configurationFile):
      print "Stopping zookeeper on port %d" % port

      # actually stop zookeeper
      arguments = [
        "ZOOCFGDIR=%s/data/zookeeper" % (configuration["installDirectory"]),
        "ZOOCFG=instance-%d.cfg" % (port),
        "%s/bin/zookeeper/bin/zkServer.sh" % (configuration["installDirectory"]),
        "stop"
      ]
      os.system(" ".join(arguments))

def createZookeeperConfigurationFile(path, dataDirectory, port):
  with open(path, 'w') as f:
    f.write("tickTime=2000\n")
    f.write("dataDir=%s\n" % dataDirectory)
    f.write("clientPort=%d\n" % port)

def cleanup(configuration):

  print "Stopping all zookeepers"
  stopZookeeper(configuration)

  print "Deleting everything under %s" % (configuration["installDirectory"])
  if os.path.exists(configuration["installDirectory"]):
    shutil.rmtree(configuration["installDirectory"])

configuration = {
  "installDirectory":"/Users/dennis/tmp/solr-go",
  "solrUrl":"http://apache.claz.org/lucene/solr/6.1.0/solr-6.1.0.tgz",
  "zookeeperUrl":"file:///Users/dennis/tmp/zookeeper-3.4.8.tar.gz",
  "zookeeperPorts": [ 20001, 20002, 20003 ]
}

cleanup(configuration)

# Zookeeper
installZookeeper(configuration)
startZookeeper(configuration)

# Solr
installSolr(configuration)

# untar("/Users/dennis/dev/lucene-solr/solr/package/solr-7.0.0-SNAPSHOT-src.tgz", "./untarred")
