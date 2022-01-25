# Dockerized Epsilon Playground

This is a dockerized version of the [Epsilon Playground](https://eclipse.org/epsilon/live).

## Build

Clone the repository and run this command:

```shell
docker image build -t playground:latest .
```

## Run

Run this command:

```shell
docker run -p 8000:80 playground:latest
```

Go to http://localhost:8000 in your browser.
