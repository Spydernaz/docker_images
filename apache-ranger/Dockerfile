FROM centos:7

ENV RANGER_ADMIN_HOME=/opt/ranger/ranger-admin
ENV RANGER_TAGSYNC_HOME=/opt/ranger/ranger-tagsync

ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV VERSION 2.1.0-SNAPSHOT

# Install Packages
RUN yum install -y java-11-openjdk-devel python2 curl vim sudo mysql-connector-java bc nc && \
    yum clean all

RUN ln -sf /usr/bin/python2 /usr/local/bin/python

RUN curl -L https://github.com/Spydernaz/docker_images/releases/download/ranger-{$VERSION}/ranger-{$VERSION}-admin.tar.gz -o /ranger-${VERSION}-admin.tar.gz \
	&& curl -L https://github.com/Spydernaz/docker_images/releases/download/ranger-{$VERSION}/ranger-{$VERSION}-tagsync.tar.gz -o /ranger-${VERSION}-tagsync.tar.gz \
	&& curl -L https://github.com/Spydernaz/docker_images/releases/download/ranger-{$VERSION}/ranger-{$VERSION}-usersync.tar.gz -o /ranger-${VERSION}-usersync.tar.gz

RUN cd /opt && mkdir ranger && cd ranger \
	&& mkdir ranger-admin ranger-tagsync ranger-usersync \
	&& tar xzf /ranger-${VERSION}-admin.tar.gz -C /opt/ranger/ranger-admin --strip-components=1 \
	&& tar xzf /ranger-${VERSION}-tagsync.tar.gz -C /opt/ranger/ranger-tagsync --strip-components=1 \
	&& tar xzf /ranger-${VERSION}-usersync.tar.gz -C /opt/ranger/ranger-usersync --strip-components=1

WORKDIR /opt

COPY ranger-entrypoint.sh /opt

EXPOSE 6080
CMD ["/bin/bash", "-c", "chmod 755 ranger-entrypoint.sh && ./ranger-entrypoint.sh"]
