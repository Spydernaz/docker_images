FROM centos:7

ENV ATLAS_SERVER_HOME=/opt/atlas/atlas-server
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
ENV VERSION 3.0.0-SNAPSHOT


# Install Packages
RUN yum install -y java-11-openjdk-devel python2 curl vim bc nc && \
    yum clean all

RUN ln -sf /usr/bin/python2 /usr/local/bin/python

RUN curl -L https://github.com/Spydernaz/docker_images/releases/download/atlas-${VERSION}/apache-atlas-${VERSION}-server.tar.gz -o /apache-atlas-${VERSION}-server.tar.gz

RUN cd /opt && mkdir atlas && cd atlas \
	&& mkdir atlas-server \
	&& tar xzf /apache-atlas-${VERSION}-server.tar.gz -C /opt/atlas/atlas-server --strip-components=1 

WORKDIR /opt

COPY atlas-entrypoint.sh /opt

EXPOSE 21000
CMD ["/bin/bash", "-c", "chmod 755 atlas-entrypoint.sh && ./atlas-entrypoint.sh"]