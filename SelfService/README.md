# Running your own iRODS environment for this course

## Getting Setup
If you dont have your own iRODs environment then you can set it up with the [iRODS Demo Docker Environmen](https://github.com/irods/irods_demo) created by RENCI. That repo has a number of docker images for assorted parts of the iRODS infrastructure. 

__N.B. Until [this has been merged](https://github.com/irods/irods_demo/pull/23/files) it's recommended to either use 4.2.8 via that MR, or use the 4.2.10 Stand-alone [Docker Container](https://github.com/metadata-school/IntroductionToiRODSCourse/tree/main/admin/docker/irods) created for this course.

```
git clone https://github.com/irods/irods_demo.git
cd irods_demo
#as the repo isn't versioned this course was written on a specific version so its reccomened to do  
git checkout 157bf84a949a19609eb7cc7961895d544dca23bf
docker-compose up
```
## icommands
For the client commands, you use the client container;

`docker exec -it irods_demo_irods-client_1 /bin/bash`

To copy a single file *to* the container;
`docker cp foo.txt irods_demo_irods-client_1:/foo.txt`

to copy a file *from* the container to your local filesystem;
`docker cp irods_demo_irods-client_1:/foo.txt foo.txt`

A folder can be copied using;

```
docker cp src/. irods_demo_irods-client_1:/target
docker cp irods_demo_irods-client_1:/src/. target
```
[Docker CLI docs for cp ](https://docs.docker.com/engine/reference/commandline/cp/)
