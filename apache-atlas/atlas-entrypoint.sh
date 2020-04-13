#!/bin/sh

#---------------------------------------
#       Wait for dependencies
#---------------------------------------
# until nc -z -v -w30 ranger-db 3306; do echo "Waiting for database connection..." && sleep 5; done
# echo "Connected to MySQL DB"
until $(curl --output /dev/null --silent --head --fail http://solr3:8983/solr); do echo "Waiting for SOLR" && sleep 5; done
# echo "Connected to SOLR instance"

#---------------------------------------
#
#       Configure Atlas Server
#
#---------------------------------------
cd $ATLAS_SERVER_HOME
echo -e "\n\n\n    ****    Configuring and installing Atlas Server    ****\n\n\n"

export MANAGE_LOCAL_HBASE=true
export MANAGE_LOCAL_SOLR=false

# # Adjust Logging Level
# sed -i 's|<level value="info"/>|<level value="debug"/>|' ./conf/atlas-log4j.xml
# sed -i 's|<level value="error"/>|<level value="debug"/>|' ./conf/atlas-log4j.xml


# Configure Kafka Settings
echo -e "\n\n\n    ****    Configuring Kafka    ****\n\n\n"
sed -i 's|atlas.notification.embedded=true|atlas.notification.embedded=false|' ./conf/atlas-application.properties
sed -i 's|atlas.kafka.data=|#atlas.kafka.data=|' ./conf/atlas-application.properties
sed -i 's|atlas.kafka.zookeeper.connect=localhost:9026|atlas.kafka.zookeeper.connect=zookeeper:2181|' ./conf/atlas-application.properties
sed -i 's|atlas.kafka.bootstrap.servers=localhost:9027|atlas.kafka.bootstrap.servers=kafka1:19091,kafka2:19092,kafka3:19093|' ./conf/atlas-application.properties

# Run the Kafka setup
python ./bin/atlas_kafka_setup.py

# Point logging section to Solr Container
echo -e "\n\n\n    ****    Configuring SOLR    ****\n\n\n"

sed -i 's|atlas.graph.index.search.solr.zookeeper-url=localhost:2181|atlas.graph.index.search.solr.zookeeper-url=zookeeper:2181|' ./conf/atlas-application.properties
# Configure Solr Collections
# curl 'http://localhost:8983/solr/admin/collections?action=CREATE&name=gettingstarted3&numShards=1&collection.configName=_default'
curl 'http://solr3:8983/solr/admin/collections?action=CREATE&name=vertex_index&numShards=3'
curl 'http://solr3:8983/solr/admin/collections?action=CREATE&name=edge_index&numShards=3'
curl 'http://solr3:8983/solr/admin/collections?action=CREATE&name=fulltext_index&numShards=3'


#---------------------------------------
#       Start Services
#---------------------------------------
PATH=$PATH:$ATLAS_SERVER_HOME/bin
atlas_start.py


#---------------------------------------
#       Keep the container running
#---------------------------------------
tail -f $ATLAS_SERVER_HOME/logs/application.*

