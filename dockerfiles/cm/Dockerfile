
FROM ubuntu:16.04
#RUN  apt-get  install -y   gcc

ARG rulles_from
ARG version

ENV   BUILD_VERSION
COPY  ecloud  /opt  


#
COPY ${rulles_from}install_cm /opt/ecloud/ 
COPY ${rulles_from}auto_cm /opt/ecloud/ 
RUN chmod +x /opt/ecloud/i686_Linux/install_cm &&  /opt/ecloud/i686_Linux/install && rm  -f /opt/ecloud/i686_Linux/install

#Ports to expose outside
EXPOSE 8030
EXPOSE 8031
EXPOSE 3306
EXPOSE 80
EXPOSE 2411

# run on start container
CMD ["/opt/ecloud/auto_cm"]

