# choose system
# ---------------------------------------------------
FROM ubuntu:16.04
#1st layer 
# ---------------------------------------------------
RUN apt-get update && apt-get install -y gcc
# ---------------------------------------------------
#2
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
#3
ENV LANG en_US.utf8
#4
RUN /usr/sbin/useradd -d /opt/ecloud -c "" "eacmuser" 
#5
#docker >= 17.09
ADD   --chown=eacmuser ecloud.tar.gz /
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
#EXPOSE 241
#https
EXPOSE  443
# ---------------------------------------------------
# supervisor script
# ---------------------------------------------------
CMD ["/opt/ecloud/rules/auto"]
# ---------------------------------------------------
