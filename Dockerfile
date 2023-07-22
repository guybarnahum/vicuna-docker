# using ubuntu LTS version
FROM ubuntu:20.04 

# avoid stuck build due to user prompt
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y python3.9 python3.9-dev python3-pip python3-wheel build-essential git && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# install requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir wheel
RUN pip3 install --no-cache-dir -r requirements.txt

RUN mkdir /code
WORKDIR /code
COPY . .

RUN python3 ./scripts/download_vicuna.py
EXPOSE 5000

# make sure all messages always reach console
ENV PYTHONUNBUFFERED=1

RUN git clone https://github.com/ggerganov/llama.cpp.git && \
    cd llama.cpp c&& \
    make

CMD ["python3.9", "app.py"]