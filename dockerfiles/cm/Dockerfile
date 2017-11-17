# choose system
# ---------------------------------------------------
FROM ubuntu:16.04
# ---------------------------------------------------
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
# ---------------------------------------------------
# options
# ---------------------------------------------------
#ARG build_vesrion
# ---------------------------------------------------

# ---------------------------------------------------
# environment section
# ---------------------------------------------------
#ENV BUILD_VERSION=${build_vesrion}
# ---------------------------------------------------
# ---------------------------------------------------
# install section
# ---------------------------------------------------
#1
RUN /usr/sbin/useradd -d /opt/ecloud -c "" "eacmuser" 

#2
COPY --chown=eacmuser  opt  /opt

#3
#RUN /opt/ecloud/rulles/install
# --------------------------------------------------- 

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
# erunner port
#EXPOSE 241
#https
EXPOSE  443
# ---------------------------------------------------
# supervisor script
# ---------------------------------------------------
CMD ["/opt/ecloud/rulles/auto"]
# ---------------------------------------------------
