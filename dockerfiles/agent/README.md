# EC Accelerator
Docker containers with Electric-Accelerator components

   *Agent*
  
To create an image with Agents:

Step 1. Run the ECFS installer on the host machine
Step 2. Run agent install on machine where docker image needs to be prepared
Step 3. Use build.sh to prepare /opt and output a docker image

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

##USAGE
```
    "Usage: ./build.sh -t=<build_target> -c=<content_folder> -s=<system_name> [-v=<build_version>]"
    "1 -t=*| --target=*          : <build_target>   - agent | cm | emake"
    "2 -v=*| --vesrsion=*        : <build_version>  - in format like 10.0 - optional"
    "3 -c=*| --contetnt_folder=* : <content_folder> - build folder to prepare content for acceletor-target docker image and build image from it"
    "4 -s=*| --system=*          : <system_name>    - rh | centos | ubuntu" 
    "5 -r  | --reuse - tell to the build image  process to reuse tar archive (if it was prepared earlier) instead of creating new one - optional" 
    "6 -r  | --help  - print help" 
```
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
```
