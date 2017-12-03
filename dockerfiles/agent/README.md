# EC Accelerator
Docker containers with Electric-Accelerator components

   *Agent*
  
  
To create an image with Agents:


Step 1. Run agent install on machine where docker image needs to be prepared

Step 2. Use build.sh to prepare /opt and output a docker image

## COMMAND1 to build RedHat image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=rh
```

## COMMAND2 to build ubuntu image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=ubuntu
```

## COMMAND3 to build centos image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=centos
```


## USAGE
```
    "Usage: ./build.sh -t=<build_target> -c=<content_folder> -s=<system_name> [-v=<build_version>]"
    "1 -t=*| --target=*          : <build_target>   - agent | cm | emake"
    "2 -v=*| --version=*         : <build_version>  - in format like 10.0 - optional"
    "3 -c=*| --content_folder=*  : <content_folder> - build folder to prepare content for acceletor-target docker image and build image from it"
    "4 -s=*| --system=*          : <system_name>    - rh | centos | ubuntu" 
    "5 -r  | --reuse - tell to the build image  process to reuse tar archive (if it was prepared earlier) instead of creating new one - optional" 
    "6 -o  | --onlytar - tar from /opt/ecloud to the tarball with name ecloud.tar.gz and exit
           should be used with flags : --target, --content_folder --system"
    "7 -h  | --help  - print help" 
```

Every build of image with agent will be created  <content_folder>/agent/ecloud.tar.gz archive.
To have ability reuse ecloud.tar.gz on a another machines for building image  (no need to install again agents ClusterManager or Emake on a machine next time)
user can use option -r or --reuse

To use  -r option:

- Please create <content_folder>  folder on your new machine - it could be something like /tmp/test

- Create folder  /tmp/test/agent

- Copy ecloud.tar.gz from your build machine to the  /tmp/test/agent

- Run build (see  COMMAND4)

## COMMAND4 to rebuild RedHat image from existed ecloud.tar.gz file 
```bash 
   CONTENT_FOLDER=/tmp/test
   mkdir -r $CONTENT_FOLDER/agent

 
cp ../from/ecloud.tar.gz  to $CONTENT_FOLDER/agent 
   
cd ecea-docker/build && \
  ./build.sh -t=agent \
   -c=$CONTENT_FOLDER \
   -s=rh \
   -r 
```

If you need to create 'ecloud.tar.gz' only - there is a flag '-o' or '--onlytar'
(you can use tarball with flag '--reuse' in future on any host)
To create 'ecloud.tar.gz':
A. Be sure that you done with installation files on a machine (Step 1.)
B. Run command : 
## create only ecloud.tar.gz and exit 
```bash
  CONTENT_FOLDER=/tmp/test
   ./build.sh -t=agent \
   -c=$CONTENT_FOLDER \
   -s=rh \
   --onlytar
```
as a condition  --onlytar | -o - options should be used with flags -t, -c, -s 
C. As a result of build proces - will printed (to the sdout) path to created 'ecloud.tar.gz'


Step 3. Run the ECFS installer on the host machine where will be started docker container with agents (Ask ElectricCloud for ECFS installer)

Step 4. Start up Docker image with the following commands:

## Command

```bash
docker run --privileged=true  -i -d -t  -e CMHOST=10.200.1.97 -e AGENT_NUMBER=8  --device /dev/efs --net=host --name=ec_agent  agent_10.0_rh_alpha
```

By default agent will be pointed on CM which placed on localhost 

To point container CM host - use:

## Example

```
-e CMHOST=10.200.1.97
```
or 

## Example

```
-e CMHOST=10.200.1.97:8030
```

To choose number of agents you can add option AGENT_NUMBER 

```
-e AGENT_NUMBER=digit_number_agents
```

## Work with container :

```bash
docker top  ec_agents
```
```bash
docker logs  ec_agents
```

```bash
docker exec  ec_agents /opt/ecloud/i686_Linux/64/bin/emake -v
```

```bash
docker exec  ec_agents /opt/ecloud/i686_Linux/64/bin/emake -f /tmp/Makefile
```

```bash
#interactive commandline
docker exec -it ec_agents bash
