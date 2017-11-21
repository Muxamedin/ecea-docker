
# EC Accelerator
Docker containers with Electric-Accelerator components
  *EMake*  *Agent* and *ClusterManager*
  
To create an image with one of component:

1. Run v10 agent install on machine where docker image is to be prepared
2. Run build.sh script to prepare /opt for docker image and build your image 

## Command
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=rh
```



##USAGE
```
   "Usage: $0 -t=<build_target> -c=<content_folder> -s=<platform name> [-v=<build_version>]"
    "1 <build_target>:   agent | cm | emake"
    "2 <build_version>:  in format like 10.0 - optional"
    "3 <content_folder>: build folder to prepare content for acceletor-target docker image and build image from it"
    "4 <platform name>:  rh | centos | ubuntu" 

             -c=*|--contetnt_folder
             -t=*|--target
             -s=*|--system
             -v=*|--vesrsion
             -h  |--help
```
As a result should be created :

Image with "<name of component>_<build version>_<>alpha"

## Example

```
  "agent_10.0_rh_alpha"
```

To run agent container we need to use option as 
```
--privileged=true --device /dev/efs --net=host
```

## Command

```bash
docker run --privileged=true  -i -d -t  -e CMHOST=10.200.1.97 -e AGENT_NUMBER=8  --device /dev/efs --net=host --name=ec_agent  agent_10.0_rh_alpha
```

By default agent will be pointed on CM which placed on localhost 

To point container on another CM host - use:

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
docker top  ea_agents
```
```bash
docker logs  ea_agents
```

```bash
docker exec  ea_agents /opt/ecloud/i686_Linux/64/bin/emake -v
```
```bash
docker exec  ea_agents /opt/ecloud/i686_Linux/64/bin/emake -f /tmp/Makefile
```

```bash
#interactive commandline
docker exec -it ea_agents bash
```


