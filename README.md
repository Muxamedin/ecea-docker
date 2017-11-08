# EC Accelerator
Docker containers with Electric-Accelerator components
  *EMake*  *Agent* and *ClusterManager*
  
To create an image with one of component:

1. Clone the current repository
2. Copy the folder with files from the ../*/agent directory to ecea-docker/:

```bash
cp ../*/agent ecea-docker/
```

## As a result should be like here :

```bash
ll ecea-docker/
drwxrwxr-x 3 build build 4096 Nov  7 19:57 agent/      <- just copyed folder
drwxrwxr-x 2 build build 4096 Nov  7 18:03 build/
drwxr-xr-x 5 build build 4096 Nov  2 17:29 dockerfiles/
drwxr-xr-x 8 build build 4096 Nov  8 09:12 .git/
-rw-rw-r-- 1 build build   24 Nov  6 21:20 .gitignore
-rw-r--r-- 1 build build   69 Nov  2 17:29 README.md
```

3. Go to build folder & run command as 

## pattern
```
   ./build <name of component> <build version> <path to folder with install content files>
```
   
## Command
```bash
./build agent "10.0.0.0" ../agent
```
As a result should be created :

Image with "<name of component>_<build version>_alpha"

## Example

```
  "agent_10.0.0.0_alpha"
```

To run agent container we need to use option as 
```
--privileged=true --device /dev/efs --net=host
```

## Command

```bash
docker run --privileged=true  -i -d -t  -e CMHOST=10.200.1.97 -e AGENT_NUMBER=8  --device /dev/efs --net=host --name=ea_agents agent_2017.10.11_alpha
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


