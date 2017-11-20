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


usage() {
    echo "Usage: $0 -t=<build_target> -c=<content_folder> [-v=<build_version>]"
    echo "1 <build_target>: agent | cm | emake"
    echo "2 <build_version>: in format like 10.0"
    echo "3 <content_folder>: folder with content files for for acceletor-target docker image"
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

if ! [ -d $CONTENT_FOLDER ]; then
    printErrorMsg "Couldn't find CONTENT_FOLDER : $CONTENT_FOLDER"
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
    printErrorMsg "There is no $DOCKER_FILE!"
fi

rm  $CONTENT_FOLDER/Dockerfile
rm  -r $CONTENT_FOLDER/opt/ecloud/rules

cp $DOCKER_FILE $CONTENT_FOLDER/

cp -r $RULES_DIR $CONTENT_FOLDER/opt/ecloud/
cd  $DOCKER_FILE_FOLDER

BUILD_VERSION_DEF=10.0 
BUILD_VERSION=${BUILD_VERSION:=$BUILD_VERSION_DEF}
IMG_NAME="${TARGET}_${BUILD_VERSION}_${SYSTEM_NAME}_alpha" 


if ! (docker build -t=$IMG_NAME .  ) then
   printErrorMsg "Image was not created!!!"
fi
