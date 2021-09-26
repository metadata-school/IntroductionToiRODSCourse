# README 

## Build 

```
# change to the version of iRODS you want to have a container for e.g.
cd admin/docker/irods/4.2.9
sudo docker image build --tag irodsserver:4.2.10 .
```

### Clean Rebuild Image

```
sudo docker stop irodsServer
sudo docker kill irodsServer
sudo docker image rm $(sudo docker image ls | grep irodsserver | awk '{print $3'})
sudo docker image rm ubuntu:18.04
sudo docker image build --tag irodsserver:4.2.9 .
```

## run docker in background 

```
sudo docker run --name irodsServer -h irodsServer -p 1248:1248 -p 1247:1247 --shm-size=512m -d --rm irodsserver:4.2.9
```

## run docker as interactive session

Best for the _nosetups images, as you may not get a shell if you kill the `start_provider.sh` script.

```
sudo docker run --name irodsServertest -h irodsServertest --shm-size=512m -it  irodsserver:test
```

### run commands from within container

```
sudo docker exec -ti irodsServer /bin/bash
su - irods
# or for a one off command 
sudo -iu irods <command>
# OR start the session as the irods user 
sudo docker exec -ti -u irods  irodsServer  /bin/bash
```
## Regenerate tar file for Educative.io

```
cd 4.2.10
tar -czvf tarball.tar.gz Dockerfile start_provider.sh db_commands.txt configure_users.py users.txt adduser.local
```
