# Dockerized Epsilon Playground

This is a dockerized version of the [Epsilon Playground](https://eclipse.org/epsilon/live).

## Fetch and Run the Docker Hub Image

Use this command to fetch the latest version of the Epsilon Playground image from Docker Hub and run it in a container:

```shell
docker run -p 8000:80 eclipseepsilon/playground:latest
```

## Build and Run the Docker Image

If you prefer to build the image from source instead of fetching it from Docker Hub, clone the repository and use this command to build the image:

```shell
docker image build -t playground:latest .
```

and this command to run the image in a container:

```shell
docker run -p 8000:80 playground:latest
```

## Access the Epsilon Playground

Once the container is up, go to http://localhost:8000 in your browser to access the playground's web interface.

## Run the Docker Image with your Own Examples

The dockerized version of the playground comes with the same set of examples as the [online version](https://eclipse.org/epsilon/live). To start an instance with your own examples on the left hand side, use the following command, replacing `<examples-folder-absolute-path>` with the **absolute** path of your `examples` folder.

```shell
docker run -p 8000:80 -v <examples-folder-absolute-path>:/etc/nginx/html/examples playground:latest
```

Your `examples` folder should contain an `examples.json` file with at least one example. A sample `examples` folder with a single example is provided [in this repository](examples) and more examples are available in the `examples` folder of [Epsilon's website repository](https://git.eclipse.org/c/www.eclipse.org/epsilon.git/tree/live/examples).

## Replace the Playground Front-End

If you would like to use only the backend services and replace the front-end altogether, you can start an instance using the following command, replacing `<front-end-folder-absolute-path>` with the **absolute** path of your custom front-end folder.

```shell
docker run -p 8000:80 -v <front-end-folder-absolute-path>:/etc/nginx/html playground:latest
```
Your front-end folder should contain an `index.html` file. A minimal alternative front-end that you can use as a starting point for developing your custom front-end is available in the `miniground` folder of [this repository](miniground).
