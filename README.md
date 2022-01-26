# Dockerized Epsilon Playground

This is a dockerized version of the [Epsilon Playground](https://eclipse.org/epsilon/live).

## Build the Docker Image

Clone the repository and run this command:

```shell
docker image build -t playground:latest .
```

## Run the Docker Image Locally

Run this command:

```shell
docker run -p 8000:80 playground:latest
```

Go to http://localhost:8000 in your browser.

## Run the Docker Image with your Own Examples

The dockerized version of the playground comes with the same set of examples as the [online version](https://eclipse.org/epsilon/live). To start an instance with your own examples on the left hand side, use the following command, replacing `<examples-folder-absolute-path>` with the **absolute** path of your `examples` folder. Your examples folder should contain an `examples.json` file with at least one example. A sample `examples` folder with a single example is provided in the repository and more examples are available in the `examples` folder of [Epsilon's website repo](https://git.eclipse.org/c/www.eclipse.org/epsilon.git/tree/live/examples).

```shell
docker run -p 8000:80 -v <examples-folder-absolute-path>:/etc/nginx/html/examples playground:latest
```