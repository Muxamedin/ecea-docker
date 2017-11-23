#!/bin/sh
#handling options
for i in "$@" 
do
        case $i in
             -c=*|--contetnt_folder=*)
             CONTENT_FOLDER="${i#*=}"
             shift # past argument=value
             ;;
             -t=*|--target=*)
             TARGET="${i#*=}"
             shift # past argument=value
             ;;
             -s=*|--system=*)
             SYSTEM_NAME="${i#*=}"
             shift # past argument=value
             ;;
             -v=*|--vesrsion=*)
             BUILD_VERSION="${i#*=}"
             shift # past argument=value
             ;;
             -h|--help)
             HELP=YES
             shift # past argument with no value
             ;;
             -r|--reuse)
             REUSE=1
             shift # past argument with no value
             ;;
             *)
             # unknown option
             ;;
        esac
done


#functions
workingdir() {
    if ! [ -d $CONTENT_FOLDER ]; then
       mkdir $CONTENT_FOLDER > /dev/null
       if [$? != "0"]; then 
         printErrorMsg "Can't create folder $CONTENT_FOLDER"
       fi 
   fi 
}



usage() {
    echo
    echo "Usage: $0 -t=<build_target> -c=<content_folder> -s=<system_name> [-v=<build_version>] [-r ]"
    echo
    echo "    1 -t=*|--target=*           : <build_target>   - agent | cm | emake"
    echo "    2 -v=*| --vesrsion=*        : <build_version>  - in format like 10.0 - optional"
    echo "    3 -c=*| --contetnt_folder=* : <content_folder> - build folder to prepare content for acceletor-target docker image and build image from it"
    echo "    4 -s=*| --system=*          : <system_name>    - rh | centos | ubuntu"
    echo "    5 -r  | --reuse - tell to the build image  process to reuse tar archive (if it was prepared earlier) instead of creating new one - optional" 
    echo "    6 -h  | --help  - print help"
    echo 
}

printErrorMsg() {
    echo "ERROR: $1"
    echo ""
    usage
    exit 1
}

logMsg() {
    echo "<-log->| $1"
}
#functions

if ! [ -z $HELP ]; then
    usage
    exit 1
fi

docker -v
  
if  [ $? != "0" ]; then
    echo "Docker is not installed or docker demon is stoped. Exit"
    exit 1
fi 

if [ "$TARGET" = "agent" ] || \
   [ "$TARGET" = "cm" ]    || \
   [ "$TARGET" = "emake" ] ; then
   logMsg "TARGET - $TARGET" 
else
    printErrorMsg "Specifyed target: $TARGET - is not in list of build targets. Should be agent or cm or emake."
fi

if [ -z $CONTENT_FOLDER ]; then
   CONTENT_FOLDER=/tmp/acc_docker
fi

logMsg "CONTENT_FOLDER - $CONTENT_FOLDER"

if ! [ -d $CONTENT_FOLDER ]; then
     logMsg "Couldn't find CONTENT_FOLDER : $CONTENT_FOLDER. I'll try to create it"
fi

#config
PWD=`pwd`
TOP=".." 

BUILD_SRCDIR=$TOP/dockerfiles/$TARGET
RULES_DIR=$BUILD_SRCDIR/rules

if [ -z $SYSTEM_NAME ] ; then
   DOCKER_FILE_FOLDER=$BUILD_SRCDIR
   SYSTEM_NAME="_"
else
   DOCKER_FILE_FOLDER=$BUILD_SRCDIR/$SYSTEM_NAME
fi
DOCKER_FILE=$DOCKER_FILE_FOLDER/Dockerfile

if  [ -d $DOCKER_FILE ]; then 
    printErrorMsg "There is no Dockerfile - $DOCKER_FILE !"
fi

BUILDDIR=$CONTENT_FOLDER/$TARGET
logMsg "BUILDDIR - $BUILDDIR"

if [ -z $REUSE ] ; then
   if [ -d $BUILDDIR ]; then 
      rm -r $BUILDDIR 
   fi  
fi

if ! [ -d $BUILDDIR ]; then
     mkdir -p  $BUILDDIR
else 
   if [ -e $BUILDDIR/exclude  ]; then
      rm -f $BUILDDIR/exclude
   fi
   if [ -e $BUILDDIR/Dockerfile  ]; then
      rm -f $BUILDDIR/Dockerfile
   fi
   if [ -d $BUILDDIR/rules  ]; then
      rm -rf $BUILDDIR/rules
   fi
fi
#add files to the build folder 
cp  $BUILD_SRCDIR/exclude  $BUILDDIR
cp  -r  $BUILD_SRCDIR/rules  $BUILDDIR
chmod +x  -R $BUILDDIR/rules
cp  $DOCKER_FILE $BUILDDIR
if  [ -z $REUSE ] ; then
   if ! [ -d /opt/ecloud  ]; then
      printErrorMsg "Accelerator  should be installed  brefore  running $0. Can't find /opt/ecloud folder."
   fi
   if [ -e $BUILDDIR/ecloud.tar.gz ]; then
      rm -f $BUILDDIR/ecloud.tar.gz
   fi
   tar -cvzf $BUILDDIR/ecloud.tar.gz --exclude-from=$BUILDDIR/exclude /opt/ecloud
else
   if ! [ -e $BUILDDIR/ecloud.tar.gz ]; then
        tar -cvzf $BUILDDIR/ecloud.tar.gz --exclude-from=$BUILDDIR/exclude /opt/ecloud
   fi 
fi

BUILD_VERSION_DEF=10.0 
BUILD_VERSION=${BUILD_VERSION:=$BUILD_VERSION_DEF}
IMG_NAME="${TARGET}_${BUILD_VERSION}_${SYSTEM_NAME}_alpha" 
# go to working directory to execute docker run
cd  $BUILDDIR

if ! (docker build -t=$IMG_NAME .  ) then
   printErrorMsg "Image was not created!!!"
else
  docker images
fi

