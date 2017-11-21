#!/bin/sh

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
             *)
             # unknown option
             ;;
        esac
done



workingdir() {
    if ! [ -d $CONTENT_FOLDER ]; then
       mkdir $CONTENT_FOLDER > /dev/null
       if [$? != "0"]; then 
         printErrorMsg "Can't create folder $CONTENT_FOLDER"
       fi 
   fi 
}



usage() {
    echo "Usage: $0 -t=<build_target> -c=<content_folder> -s=<platform name> [-v=<build_version>]"
    echo "1 <build_target>: agent | cm | emake"
    echo "2 <build_version>: in format like 10.0"
    echo "3 <content_folder>: build folder to prepare content for acceletor-target docker image and build image from it"
    echo "4 <platform name>:  rh | centos | ubuntu" 
    
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



if ! [ -z $HELP ]; then
    usage
fi

docker -v  
if  [ $? != "0" ]; then
    echo "Docker is not installed or docker demon is stoped. Exit"
    exit 1
fi 

if [ "$TARGET" = "agent" ] || \
   [ "$TARGET" = "cm" ]    || \
   [ "$TARGET" = "emake" ] ; then
   echo "Target = $TARGET" 
else
    echo "Target : $TARGET - is not in list of build targets"
fi

if  [ -z $CONTENT_FOLDER ]; then
    CONTENT_FOLDER=/tmp/acc_docker
fi

logMsg "CONTENT_FOLDER = $CONTENT_FOLDER"

if ! [ -d $CONTENT_FOLDER ]; then
    logMsg "Couldn't find CONTENT_FOLDER : $CONTENT_FOLDER"
fi



PWD=`pwd`
TOP=".." 

BUILD_SRCDIR=$TOP/dockerfiles/$TARGET
RULES_DIR=$BUILD_SRCDIR/rules

if  [ -z $SYSTEM_NAME ] ; then
   DOCKER_FILE_FOLDER=$BUILD_SRCDIR
   SYSTEM_NAME="_"
else
   DOCKER_FILE_FOLDER=$BUILD_SRCDIR/$SYSTEM_NAME
fi
DOCKER_FILE=$DOCKER_FILE_FOLDER/Dockerfile

if  [ -d $DOCKER_FILE ]; then 
    printErrorMsg "There is no Dockerfile - $DOCKER_FILE !"
fi

#rm  $CONTENT_FOLDER/Dockerfile
#rm  -r $CONTENT_FOLDER/opt/ecloud/rules
#cp $DOCKER_FILE $CONTENT_FOLDER/
#cp -r $RULES_DIR $CONTENT_FOLDER/opt/ecloud/


BUILDDIR=$CONTENT_FOLDER/$TARGET/$SYSTEM_NAME
if [ -d $BUILDDIR ]; then 
    rm -r $BUILDDIR 
fi 


mkdir -p  $BUILDDIR
cp  $BUILD_SRCDIR/exclude  $BUILDDIR
cp  -r  $BUILD_SRCDIR/rules  $BUILDDIR
chmod +x  -R $BUILDDIR/rules
cp  $DOCKER_FILE $BUILDDIR
tar -cvzf $BUILDDIR/ecloud.tar.gz --exclude-from=$BUILDDIR/exclude /opt/ecloud


BUILD_VERSION_DEF=10.0 
BUILD_VERSION=${BUILD_VERSION:=$BUILD_VERSION_DEF}
IMG_NAME="${TARGET}_${BUILD_VERSION}_${SYSTEM_NAME}_alpha" 
cd  $BUILDDIR
if ! (docker build -t=$IMG_NAME .  ) then
   printErrorMsg "Image was not created!!!"
else
  docker images
fi
