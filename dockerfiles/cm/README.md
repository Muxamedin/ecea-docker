# EC Accelerator
Docker containers with Electric-Accelerator components

   *ClusterManager*
  
To create an image with ClusterManager:



Step 1. Run Accelerator ClusterManager install on machine where docker image needs to be prepared

Step 2. Use build.sh to prepare /opt and output a docker image


## COMMAND1 to build RedHat image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=cm -s=rh
```

## COMMAND2 to build ubuntu image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=cm -s=ubuntu
```

## COMMAND3 to build centos image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=cm -s=centos
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
(Be sure that there is no localy installed ClusterManager on a machine)

## Command

```bash
docker run  -i -d -t  -p 80:80 -p 8080:8080 -p 8081:8081 -p 443:443 -p 3306:3306 --name=cm1  cm_10.0_rh_alpha
```
Step 5. Lunch ip address of machine, where was started docker continer with clustermanager, in addres bar  - to see ClusterManager UI 


## Work with container :

```bash
docker top  cm1
```
```bash
docker logs  cm1
```

```bash
#interactive commandline
docker exec -it cm bash
```
