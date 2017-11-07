# choose system
# ---------------------------------------------------
FROM ubuntu:16.04
# ---------------------------------------------------

# ---------------------------------------------------
# options
# ---------------------------------------------------
#ARG build_vesrion
#ARG agent_version
#ARG cmhost
#ARG cmport
#ARG lsf_host
#ARG secure_console
#ARG tempdir
#"2017.10.11"
ARG agent_version
# ---------------------------------------------------

# ---------------------------------------------------
# environment section
# ---------------------------------------------------
ENV BUILD_VERSION=${agent_version}
# ---------------------------------------------------

# ---------------------------------------------------
# install section
# ---------------------------------------------------
COPY  opt  /opt
#chmod +x /opt/ecloud/rulles/install && \
RUN /opt/ecloud/rulles/install && \
rm  -f /opt/ecloud/rulles/install ; chmod  755  /opt/ecloud/rulles/auto
#----------------------------------------------------
# supervisor script
# ---------------------------------------------------
CMD ["/opt/ecloud/rulles/auto"]
# ---------------------------------------------------
