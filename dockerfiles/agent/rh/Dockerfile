# choose system ---------------------------------------------------
#FROM chanchal/rhel72
FROM yjjy0921/redhat7.2

#0
#RUN yum -y update; yum clean all
#RUN yum -y install epel-release; yum clean all
#RUN yum install -y gcc;  yum clean all
#1st layer
# ---------------------------------------------------
ADD ecloud.tar.gz /
# 3d layer -----------------------------------------
COPY rules /opt/ecloud/rules
# 4d layer -----------------------------------------
RUN /opt/ecloud/rules/install
#----------------------------------------------------
# supervisor script --------------------------------
CMD ["/opt/ecloud/rules/auto"]
# ---------------------------------------------------
