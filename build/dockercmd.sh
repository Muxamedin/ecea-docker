#!/bin/sh

# docker rm exited containers - clean containers from machine
dr_rmec () {
  docker -v
  if ! [ $? == 0 ] ; then
      echo "Docker is not installed or docker  demon  stoped.Exit"
      exit 1
  fi
 if !  ( docker rm `docker ps -a | grep  Exited | awk '{print $1}'` 2>/dev/null ); then
    echo "There was no any Exited  containers on a host"
 fi

}

#docker rmi all images - clean images from machine
dr_rmi () {
  docker -v
  if ! [ $? == 0 ] ; then
      echo "Docker is not installed or docker  demon  stoped.Exit"
      exit 1
  fi
  docker rmi `docker images | grep ago | awk '{print $3}'` 2>/dev/null

}
# dr_runagent
# run docker container with electric agent
# options :
# echo "$0  -i=*|--imagename=* [-cn=*|--containername=*] [-an=*|--agentsnumber=*] [-cm=*|--cmhost=*]"
#  "-i  --imagename     : image name"
#  "-cn --containername : unic container name to manage container by name, ea_container1"
#  "-an --agentsnumber  : number of agents , by default 1"
#  "-cm --cmhost        : IP addres of CM , by default  localhost"
dr_runagent () {
    CMHOST=localhost
    AGENT_NUMBER=1
    CONTAINER_NAME=ea_container1
    for i in "$@"
    do
    case $i in
            -cm=*|--cmhost=*)
            CMHOST="${i#*=}"
            shift # past argument=value
            ;;
            -an=*|--agentsnumber=*)
            AGENT_NUMBER="${i#*=}"
            shift # past argument=value
            ;;
            -i=*|--imagename=*)
            IMAGE_NAME="${i#*=}"
            shift # past argument=value
            ;;
            -cn=*|--containername=*)
            CONTAINER_NAME="${i#*=}"
            shift # past argument=value
            ;;
            -h|--help)
            HELP=YES
            shift # past argument with no value
            ;;
            *)
            # unknown option
            ;;
    esac
    done
    if ! [ -z $HELP  ] || [ -z $IMAGE_NAME  ]; then
           echo USAGE:
           echo "$0  -i=*|--imagename=* [-cn=*|--containername=*]  [-an=*|--agentsnumber=*]  [-cm=*|--cmhost=*]"
           echo "-i  --imagename      : image name"
           echo "-cn --containername : unic container name to manage container by name, ea_container1"
           echo "-an --agentsnumber  : number of agents , by default 1 "
           echo "-cm --cmhost        : IP addres of CM , by default localhost"
           exit 1
    fi
    echo "CMHOST           = ${CMHOST}"
    echo "AGENT_NUMBER     = ${AGENT_NUMBER}"
    echo "IMAGE_NAME       = ${IMAGE_NAME}"
    echo "CONTAINER_NAME   = ${CONTAINER_NAME}"
    docker -v
    if ! [ $? = 0 ] ; then
      echo "Docker is not installed or docker demon stoped. Exit"
      exit 1
    fi
    docker run --privileged=true -i -d -t  -e CMHOST=$CMHOST -e AGENT_NUMBER=$AGENT_NUMBER  --device /dev/efs --net=host --name=$CONTAINER_NAME $IMAGE_NAME
    if [ $? = 0 ]; then
       echo : $CONTAINER_NAME - container started
    fi
}
