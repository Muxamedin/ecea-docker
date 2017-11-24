# EC Accelerator
Docker containers with Electric-Accelerator components

   *Emake*
  
To create an image with Emake:



Step 1. Run Accelerator Emake install on machine where docker image needs to be prepared

Step 2. Use build.sh to prepare /opt and output a docker image


## COMMAND1 to build RedHat image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=rh
```

## COMMAND2 to build ubuntu image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=ubuntu
```

## COMMAND3 to build centos image
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=centos
```

## USAGE
```
    "Usage: ./build.sh -t=<build_target> -c=<content_folder> -s=<system_name> [-v=<build_version>]"
    "1 -t=*| --target=*          : <build_target>   - agent | cm | emake"
    "2 -v=*| --vesrsion=*        : <build_version>  - in format like 10.0 - optional"
    "3 -c=*| --contetnt_folder=* : <content_folder> - build folder to prepare content for acceletor-target docker image and build image from it"
    "4 -s=*| --system=*          : <system_name>    - rh | centos | ubuntu" 
    "5 -r  | --reuse - tell to the build image  process to reuse tar archive (if it was prepared earlier) instead of creating new one - optional" 
    "6 -h  | --help  - print help" 
```
Step 4. Start up Docker image with the following commands:


## Command

```bash
docker run  -it -v /home/dev/prj:/home/dev/prj  -w /home/dev/prj --name=emake_c  emake_10.0_ubutnut_alpha
```

## Work with container :

```bash
docker top  emake_c
```
```bash
docker logs  emake_c
```

```bash
#interactive commandline
docker exec -it emake_c bash
```
