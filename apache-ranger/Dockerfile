FROM maven:3.6.2-jdk-8 AS stage-atlas

ENV ATLAS_VERSION 2.0.0
ENV TARBALL apache-atlas-${ATLAS_VERSION}-sources.tar.gz
ENV	ATLAS_REPO      https://dist.apache.org/repos/dist/release/atlas/${ATLAS_VERSION}/${TARBALL}
ENV	MAVEN_OPTS	"-Xms2g -Xmx2g"

RUN git clone http://github.com/apache/ranger.git \
	&& cd ranger \
	&& mvn clean -DskipJSTests -DskipTests package \
    && mv target/ranger-*-tagsync.tar.gz /apache-ranger-tagsync.tar.gz \
    && mv target/ranger-*-usersync.tar.gz /apache-ranger-usersync.tar.gz \
    && mv target/ranger-*-admin.tar.gz /apache-ranger-admin.tar.gz 

FROM centos:7

COPY --from=stage-atlas /apache-ranger-*.tar.gz /

ENV RANGER_ADMIN_HOME=/opt/ranger/apache-ranger-admin
ENV RANGER_TAGSYNC_HOME=/opt/ranger/apache-ranger-tagsync

ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Install Packages
RUN yum install -y java-1.8.0-openjdk-devel python2 curl vim sudo mysql-connector-java bc nc && \
    yum clean all

RUN ln -sf /usr/bin/python2 /usr/local/bin/python

RUN cd /opt \
	&& tar xzf /apache-ranger-admin.tar.gz -C /opt/ranger-admin --strip-components=1 \
	&& tar xzf /apache-ranger-tagsync.tar.gz -C /opt/ranger-tagsync --strip-components=1 \
	&& tar xzf /apache-ranger-usersync.tar.gz -C /opt/ranger-usersync --strip-components=1

WORKDIR /opt


COPY ranger-entrypoint.sh /opt


EXPOSE 6080
CMD ["/bin/bash", "-c", "chmod 755 ranger-entrypoint.sh && ./ranger-entrypoint.sh"]
