FROM python:3.9-slim-buster

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /code
WORKDIR /code

COPY requirements.txt .
RUN python3.9 -m pip install --no-cache-dir --upgrade \
    pip \
    setuptools \
    wheel
RUN python3.9 -m pip install --no-cache-dir \
    -r requirements.txt
RUN git clone https://github.com/ggerganov/llama.cpp.git && \
    cd llama.cpp && \
    make
COPY . .
RUN python3.9 ./scripts/download_vicuna.py

EXPOSE 5000

CMD ["python3.9", "app.py"]