# EC Accelerator
Docker containers with Electric-Accelerator components

   *Emake*
  
To create a docker image with Emake:

Step 1. Run Accelerator Emake install on machine where docker image needs to be prepared

Step 2. Use build.sh to prepare /opt and output a docker image

Examples :

To create docker image on RedHat
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=rh
```

To create docker image on Ubuntu
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=ubuntu
```

To create docker image on CentOS
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/build -t=emake -s=centos
```

Step 4. Start up docker image

Example :
```bash
docker run -it -d -v /home/dev/prj:/home/dev/prj  -w /home/dev/prj --name=emake_c  emake_10.0_ubuntu_alpha
```

## USAGE
```
    "Usage: ./build.sh -t=<build_target> -c=<content_folder> -s=<system_name> [-v=<build_version>]"
    "1 -t=*| --target=*          : <build_target>   - agent | cm | emake"
    "2 -v=*| --version=*         : <build_version>  - in format like 10.0 - optional"
    "3 -c=*| --content_folder=* : <content_folder> - build folder to prepare content for acceletor-target docker image and build image from it"
    "4 -s=*| --system=*          : <system_name>    - rh | centos | ubuntu" 
    "5 -r  | --reuse - tell to the build image  process to reuse tar archive (if it was prepared earlier) instead of creating new one - optional" 
    "6 -o  | --onlytar - tar from /opt/ecloud to the tarball with name ecloud.tar.gz and exit
           should be used with flags : --target, --content_folder --system"
    "7 -h  | --help  - print help" 
```
