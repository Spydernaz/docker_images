#!/bin/sh

#---------------------------------------
#       Wait for dependencies
#---------------------------------------
# until nc -z -v -w30 ranger-db 3306; do echo "Waiting for database connection..." && sleep 5; done
# echo "Connected to MySQL DB"
until $(curl --output /dev/null --silent --head --fail http://solr3:8983/solr); do echo "Waiting for SOLR" && sleep 5; done
# echo "Connected to SOLR instance"

#---------------------------------------
#       Create a SOLR Collection for Ranger
#---------------------------------------
# curl -u solr:SolrRocks "http://logging:8983/solr/admin/collections?action=CREATE&name=ranger_audits&numShards=1&replicationFactor=0&collection.configName=ranger_audits&maxShardsPerNode=100"


#---------------------------------------
#
#       Configure Atlas Server
#
#---------------------------------------
cd $ATLAS_SERVER_HOME
echo -e "\n\n\n    ****    Configuring and installing Atlas Server    ****\n\n\n"

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=true

# Point logging section to Solr Container
sed -i 's|atlas.graph.index.search.solr.zookeeper-url=localhost:2181|atlas.graph.index.search.solr.zookeeper-url=zoo1:2181|' ./conf/atlas-application.properties

# Configure Solr Collections
# curl 'http://localhost:8983/solr/admin/collections?action=CREATE&name=gettingstarted3&numShards=1&collection.configName=_default'



#---------------------------------------
#       Start Services
#---------------------------------------
PATH=$PATH:$ATLAS_SERVER_HOME/bin
atlas_start.py


#---------------------------------------
#       Keep the container running
#---------------------------------------
tail -f $ATLAS_SERVER_HOME/logs/application.log

