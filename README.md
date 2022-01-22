# Dockerized Epsilon Playground

## Build

Run this command:

```shell
docker image build -t playground:latest .
```

## Run

Run this command:

```shell
docker run --rm \
  -p 8000:8000 -p 8001:8001 -p 8002:8002 -p 8003:8003 \
  playground:latest
```

Go to http://localhost:8000 in your browser.