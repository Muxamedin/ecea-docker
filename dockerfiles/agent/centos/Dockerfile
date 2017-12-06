# choose system ---------------------------------------------------
FROM  centos 

#0st 
RUN yum -y update; yum clean all
RUN yum -y install epel-release gcc gcc-c++.x86_64; yum clean all
#1st 
# ---------------------------------------------------
ADD ecloud.tar.gz /
# 3d 
COPY rules /opt/ecloud/rules
# 4d 
RUN /opt/ecloud/rules/install
#----------------------------------------------------
# supervisor script ---------------------------------
CMD ["/opt/ecloud/rules/auto"]
# ---------------------------------------------------
