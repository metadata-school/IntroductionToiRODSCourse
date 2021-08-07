# README 

## Build 

```
# change to the version of iRODS you want to have a container for e.g.
cd admin/docker/irods/4.2.10
sudo docker image build --tag irodsserver:4.2.10 .
```

## run docker in background 

```
sudo docker run --name irodsServer -h irodsServer -p 1248:1248 -p 1247:1247 --shm-size=512m -d --rm irodsserver:4.2.10
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