# choose system ---------------------------------------------------
#FROM  centos 
#FROM chanchal/rhel72
FROM  darksolar/rhel6.6-gcc4.9	

#0
#RUN yum install -y gcc
#1st layer
# ---------------------------------------------------
COPY ecloud/ /opt
# 3d layer -----------------------------------------
COPY rules /opt/ecloud
# 4d layer -----------------------------------------
RUN /opt/ecloud/rules/install
#----------------------------------------------------
# supervisor script --------------------------------
CMD ["/opt/ecloud/rules/auto"]
# ---------------------------------------------------
