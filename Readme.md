https://medium.com/@martin-thissen/vicuna-on-your-cpu-gpu-best-free-chatbot-according-to-gpt-4-c24b322a193a

## Models
As usual exist on huggingface

```https://huggingface.co/localmodels/Llama-2-7B-Chat-ggml/tree/main```

Stored in models directory to provided to ```llama.cpp```

## Docker cheatsheet (you should know this by now)

```
docker build -t DOCKER_IMAGE . 
docker image ls
docker ps -a
```

### Deleting and Pruning
 
```
docker ps -a --filter "ancestor=DOCKER_IMAGE" --format "{{.ID}}" 
docker container rm $(docker ps -a --format "{{.ID}}")
docker image prune
```
 
### Interactive mode

```
docker run -it -rm DOCKER_IMAGE /bin/bash
```

### CLI invokation

```
vicuna-docker % make run-cli
docker run -i -t --rm -p=5000:5000 -v="/Users/titan/projects/vicuna-docker/models:/code/models" --name=""vicuna-docker"" "vicuna-docker" /bin/bash
root@08b626fb4418:/code# ls
app.py  llama.cpp  models
root@08b626fb4418:/code# ./llama.cpp/main -m ./models/vicuna-7b-v1.3-superhot-8k.ggmlv3.q4_K_S.bin --color -f ./llama.cpp/prompts/alpaca.txt -ins -b 256 --top_k 10000 --temp 0.2 --repeat_penalty 1 -t 7
```

### Notes

Notice: Apple Silicon requires gcc-9 g++-9 

Resolution: Failed to install gxx-9 on python:3.9-slim-buster using Ubuntu LTS ubuntu:20.04
