FROM centos:7

ENV VERSION 2.1.0-SNAPSHOT
ENV RANGER_ADMIN_HOME=/opt/ranger/ranger-admin
ENV RANGER_TAGSYNC_HOME=/opt/ranger/ranger-tagsync

ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Install Packages
RUN yum install -y java-1.8.0-openjdk-devel python2 curl vim sudo mysql-connector-java bc nc && \
    yum clean all

RUN ln -sf /usr/bin/python2 /usr/local/bin/python

COPY binaries/ranger-${VERSION}-admin.tar.gz /apache-ranger-admin.tar.gz
COPY binaries/ranger-${VERSION}-tagsync.tar.gz /apache-ranger-tagsync.tar.gz
COPY binaries/ranger-${VERSION}-usersync.tar.gz /apache-ranger-usersync.tar.gz

RUN cd /opt && mkdir ranger && cd ranger \
	&& mkdir ranger-admin ranger-tagsync ranger-usersync \
	&& tar xzf /apache-ranger-admin.tar.gz -C /opt/ranger/ranger-admin --strip-components=1 \
	&& tar xzf /apache-ranger-tagsync.tar.gz -C /opt/ranger/ranger-tagsync --strip-components=1 \
	&& tar xzf /apache-ranger-usersync.tar.gz -C /opt/ranger/ranger-usersync --strip-components=1

WORKDIR /opt


COPY ranger-entrypoint.sh /opt


EXPOSE 6080
CMD ["/bin/bash", "-c", "chmod 755 ranger-entrypoint.sh && ./ranger-entrypoint.sh"]
