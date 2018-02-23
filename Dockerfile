FROM nimmis/java-centos:openjdk-8-jdk

#RUN rm -rf /etc/yum.repos.d/*
#RUN curl -o /etc/yum.repos.d/Centos-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
RUN echo -e "[cloudera-cdh5]\n\
# Packages for Cloudera's Distribution for Hadoop, Version 5, on RedHat    or CentOS 7 x86_64\n\
name=Cloudera's Distribution for Hadoop, Version 5\n\
baseurl=https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/5.10.1/\n\
gpgkey =https://archive.cloudera.com/cdh5/redhat/7/x86_64/cdh/RPM-GPG-KEY-cloudera\n\
gpgcheck = 1\n\
" > /etc/yum.repos.d/cloudera-cdh5.repo

RUN yum clean all
RUN yum makecache
RUN yum install -y hive-server2 hue
RUN systemctl enable hive-server2
RUN systemctl enable hue

RUN mkdir -p /user/hive/warehouse
RUN chown hive:hive /user/hive/warehouse

VOLUME /var/log/hive
VOLUME /var/log/hue

VOLUME /var/lib/hive
VOLUME /var/lib/hue

VOLUME /user/hive/warehouse

EXPOSE 8888
EXPOSE 10000
EXPOSE 10002

CMD ["/usr/sbin/init"]

