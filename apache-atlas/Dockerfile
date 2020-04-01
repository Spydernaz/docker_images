# FROM maven:3.5.4-jdk-8 AS stage-atlas

# ENV ATLAS_VERSION 2.0.0
# ENV TARBALL apache-atlas-${ATLAS_VERSION}-sources.tar.gz
# ENV	ATLAS_REPO      https://dist.apache.org/repos/dist/release/atlas/${ATLAS_VERSION}/${TARBALL}
# ENV	MAVEN_OPTS	"-Xms2g -Xmx2g"

# RUN git clone http://github.com/apache/atlas.git \
# 	&& cd atlas \
# 	&& mvn clean -DskipTests package -Pdist,embedded-hbase-solr \
# 	&& mv distro/target/apache-atlas-*-bin.tar.gz /apache-atlas.tar.gz

FROM centos:7

RUN yum update -y \
	&& yum install -y python python37 java-11-openjdk-devel net-tools maven git \
	&& yum clean all

COPY ./binaries/* /atlas/

WORKDIR /atlas

RUN (for TARBALL in ./*-server.tar.gz; do tar -zxf "$TARBALL"; done) \
    && rm *.tar.gz \
    && ls \
    && mv apache-atlas-*/* ./ \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/atlas.graph.storage.backend=hbase2/atlas.graph.storage.backend=cassandra/g' conf/atlas-application.properties \
    && sed -i 's/atlas.graph.storage.hbase.regions-per-server=1/atlas.graph.storage.port=7000/g' conf/atlas-application.properties \
    && sed -i 's/atlas.graph.storage.hostname=/atlas.graph.storage.clustername=JanusGraph/g' conf/atlas-application.properties \
    && sed -i 's/atlas.graph.storage.lock.wait-time=10000/#atlas.graph.storage.lock.wait-time=10000/g' conf/atlas-application.properties \
    && sed -i 's/atlas.graph.storage.hbase.table=apache_atlas_janus/#atlas.graph.storage.hbase.table=apache_atlas_janus/g' conf/atlas-application.properties
RUN mv /atlas/conf/cassandra.yml.template /atlas/conf/cassandra.yml \
    && sed -i 's/127.0.0.1/cassandra/g' /atlas/conf/cassandra.yml \
    && sed -i 's/localhost/cassandra/g' /atlas/conf/cassandra.yml \
    && sed -i 's/rpc_address: localhost/rpc_address: cassandra/g' /atlas/conf/cassandra.yml


CMD ["/bin/bash", "-c", "/atlas/bin/atlas_start.py & tail -fF /atlas/logs/application.log"] 
EXPOSE 21000