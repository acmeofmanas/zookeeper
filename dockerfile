FROM repo2a.cld.uat.dbs.com:5000/rhscl/python-35-rhel7

ENV JAVA_HOME=/opt/java
ENV tickTime=2000
ENV dataDir=/var/lib/zookeeper/
ENV dataLogDir=/var/log/zookeeper/
ENV clientPort=2181
ENV initLimit=5
ENV syncLimit=2

COPY repo/base.repo /etc/yum.repos.d/
COPY repo/1593288407078963060-key.pem /etc/pki/entitlement/
COPY repo/1593288407078963060.pem /etc/pki/entitlement/
COPY repo/katello-server-ca.pem /etc/rhsm/ca/katello-server-ca.pem
COPY repo/RPM-GPG-KEY-redhat-release /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release

COPY imply-3.2.0.tar.gz /tmp/
RUN mkdir /opt/java
COPY java /opt/java
COPY tls-ca-bundle.pem /var/tmp/

USER root
WORKDIR /opt
RUN chmod 777 /tmp/imply-3.2.0.tar.gz
RUN tar xvf /tmp/imply-3.2.0.tar.gz

#CMD [ "python3.6", "launcher.py" ]
ADD entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/usr/share/zookeeper/entrypoint.sh"]
