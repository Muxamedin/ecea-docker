# EC Accelerator
Docker containers with electric accelerator components
electric accelerator components:
  -EMake
  -Agent 
  -ClusterManager 
To create Image with one of component inside :

1. Clone current repository
2. Copy component content files in top folder with cloned files:
see how it looks like for agent component:

## looks like 

```bash
ll ecea-docker/
drwxrwxr-x 3 build build 4096 Nov  7 19:57 agent/      <- folder with content install content
drwxrwxr-x 2 build build 4096 Nov  7 18:03 build/
drwxr-xr-x 5 build build 4096 Nov  2 17:29 dockerfiles/
drwxr-xr-x 8 build build 4096 Nov  8 09:12 .git/
-rw-rw-r-- 1 build build   24 Nov  6 21:20 .gitignore
-rw-r--r-- 1 build build   69 Nov  2 17:29 README.md
```

3. Go to build folder & run command as 

## Example
```
   ./build <name of component> <build version> <path to folder with install content files>
```
   
## Example
```bash
build agent "10.0.0.0" ../agent
```
As a result should be created :

Image with "<name of component>_<build version>_alpha"

## Example

```
  agent_10.0.0.0_alpha
```

To run agent container we need to use option as 
```
--privileged=true --device /dev/efs --net=host
```

## Example

```bash
docker run --privileged=true  -i -d -t  -e CMHOST=10.200.1.97  --device /dev/efs --net=host --name=c7 agent_2017.10.11_alpha
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
