## Docker cheatsheet (you should know this by now)

```
docker build -t DOCKER_IMAGE . 
docker image ls
docker ps -a
```

### Deleting and Pruning
 
```
docker container rm $(docker ps -a --format "{{.ID}}")
docker image prune
```
 
### Interactive mode

```
docker run -it -rm DOCKER_IMAGE /bin/bash
```

### Notes

Notice: Apple Silicon requires gcc-9 g++-9 

Resolution: Failed to install gxx-9 on python:3.9-slim-buster using Ubuntu LTS ubuntu:20.04
