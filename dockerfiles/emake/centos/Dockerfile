# choose system ---------------------------------------------------
FROM  centos 
#0
RUN  yum -y update &&  yum -y install epel-release  gcc gcc-c++.x86_64  ;  yum clean all
#3
ADD  ecloud.tar.gz /
#4
COPY rules /opt/ecloud/rules
# supervisor script 
#--------------------------------
CMD ["/opt/ecloud/rules/auto"]
# -------------------------------
