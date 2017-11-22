# EC Accelerator
Docker containers with Electric-Accelerator components

   *Agent*
  
To create an image with Agent:

1. Run v10 agent install on machine where docker image is to be prepared
2. Run build.sh script to prepare /opt for docker image and build your image 

## COMMAND1
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=rh
```

## COMMAND2
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=ubuntu
```

## COMMAND3
```bash
   cd ecea-docker/build ;
  ./build.sh -c=/tmp/test -t=agent -s=centos
```



##USAGE
```
   "Usage: $0 -t=<build_target> -c=<content_folder> -s=<platform name> [-v=<build_version>]"
    "1 <build_target>:   agent | cm | emake"
    "2 <build_version>:  in format like 10.0 - optional"
    "3 <content_folder>: build folder to prepare content for acceletor-target docker image and build image from it"
    "4 <platform name>:  rh | centos | ubuntu" 

             -c=*|--contetnt_folder=*
             -t=*|--target=*
             -s=*|--system=*
             -v=*|--vesrsion=*
             -h  |--help=*
```

