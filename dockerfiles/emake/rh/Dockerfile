FROM chanchal/rhel72

#0
RUN yum -y update; yum clean all
#1
RUN yum -y install epel-release; yum clean all
#2
RUN yum install -y gcc;  yum clean all
#3
ADD  ecloud.tar.gz /
#4
COPY rules /opt/ecloud/rules
# supervisor script 
#--------------------------------
CMD ["/opt/ecloud/rules/auto"]
# -------------------------------
