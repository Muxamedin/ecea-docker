# choose system ---------------------------------------------------
#FROM  centos 
#FROM chanchal/rhel72
FROM  darksolar/rhel6.6-gcc4.9	

#0
#RUN yum -y update; yum clean all
#1
#RUN yum -y install epel-release; yum clean all
#2
#RUN yum install -y gcc;  yum clean all
#3
RUN  /usr/sbin/useradd -d /opt/ecloud -c "" "eacmuser" 
# ---------------------------------------------------
#4
#docker >= 17.09
ADD  --chown=eacmuser  ecloud.tar.gz /
#5 -----------------------------------------
COPY rules /opt/ecloud/rules
# ---------------------------------------------------
# expose section
# --------------------------------------------------- 
# cm agent port
EXPOSE 8030
# cm agent secure port
EXPOSE 8031
#db
EXPOSE 3306
# http port
EXPOSE 80
#erunner port
#EXPOSE 2411
#https
EXPOSE  443

# supervisor script --------------------------------
CMD ["/opt/ecloud/rules/auto"]
# ---------------------------------------------------
