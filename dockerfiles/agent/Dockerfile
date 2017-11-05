ARG build_vesrion
FROM ubuntu:16.04
#RUN  dpkg --add-architecture i386
#RUN  apt-get update && apt-get install -y openssh-server 
#RUN  apt-get  install -y   gcc

ARG agent_version
ARG cmhost
ARG cmport
ARG lsf_host
ARG secure_console
ARG tempdir

#"2017.10.11"
# sets the ienvironment variable  NOTVISIBLE
#ENV NOTVISIBLE "in users profile"
ARG agent_version
ENV AGENTVERSION=${agent_version}
#RUN echo "export VISIBLE=now" >> /etc/profile
COPY  opt  /opt
RUN chmod +x /opt/ecloud/i686_Linux/install
RUN  /opt/ecloud/i686_Linux/install
RUN  rm  -f /opt/ecloud/i686_Linux/install
# ErunnerD port
#EXPOSE 2411
#EXPOSE 8030
#EXPOSE 8031
# automaticaly  run  after build of  container
#CMD ["/usr/sbin/sshd", "-D"]
#CMD ["/etc/init.d/erunner", "start"]
#CMD ["/etc/init.d/ecagent", "start"]
CMD ["/opt/ecloud/i686_Linux/supervisor"]


