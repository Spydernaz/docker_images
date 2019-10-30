FROM centos:latest
LABEL maintainer="Nathaniel Vala"
LABEL github="github.com/Spydernaz"

EXPOSE 749 88


RUN yum update -y && yum install -y krb5-server krb5-libs

COPY krb5.conf /etc/krb5.conf
COPY kdc.conf /var/kerberos/krb5kdc/kdc.conf
COPY kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

ENV MASTER_PASSWORD=MASTER_PASSWORD

COPY init-script.sh /tmp/

RUN chmod 777 /tmp/init-script.sh

CMD /tmp/init-script.sh
