# Dockerized Epsilon Playground

This is a Dockerized version of the [Epsilon Playground](https://eclipse.org/epsilon/playground).

## Fetch and Run the Image

Use this command to fetch the latest version of the Epsilon Playground image from Github Packages and run it in a container:

```shell
docker run --rm -p 8000:80 ghcr.io/epsilonlabs/playground-docker:micronaut
```

## Build and Run the Docker Image

### Setting up token-based access to the playground-micronaut packages

If you prefer to build the image from source instead of fetching it, first ensure that your `$HOME/.m2/settings.xml` has a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) that can read public repositories associated to the `github-playground-micronaut` server.

The `settings.xml` file could look like this:

```xml
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <id>github-playground-micronaut</id>
      <username>YOUR_GITHUB_USERNAME</username>
      <password>YOUR_GITHUB_TOKEN</password>
    </server>
  </servers>
</settings>
```

### Building the image

You can now clone the repository and use this command to build the image:

```shell
./docker-build.sh
```

### Running the image

Use this command to run the image in a container:

```shell
docker run -p 8000:80 playground-docker:micronaut
```

Should you need to customise the port that `nginx` runs on, you can do so through the `PORT` environment variable (as required by Google Cloud Build):

```shell
docker run --env PORT=8020 -p 8000:8020 playground-docker:micronaut
```

## Access the Epsilon Playground

Once the container is up, go to http://localhost:8000 in your browser to access the playground's web interface.

## Run the Docker Image with your Own Examples

The dockerized version of the playground comes with the same set of examples as the [online version](https://eclipse.org/epsilon/playground). To start an instance with your own examples on the left hand side, use the following command, replacing `<examples-folder-absolute-path>` with the **absolute** path of your `examples` folder.

```shell
docker run -p 8000:80 -v <examples-folder-absolute-path>:/etc/nginx/html/examples playground-docker:micronaut
```

Your `examples` folder should contain an `examples.json` file with at least one example. A sample `examples` folder with a single example is provided [in this repository](examples) and more examples are available in the `examples` folder of [Epsilon's website repository](https://github.com/eclipse-epsilon/epsilon-website/tree/main/mkdocs/docs/playground/examples).

## Replace the Playground Front-End

If you would like to use only the backend services and replace the front-end altogether, you can start an instance using the following command, replacing `<front-end-folder-absolute-path>` with the **absolute** path of your custom front-end folder.

```shell
docker run -p 8000:80 -v <front-end-folder-absolute-path>:/etc/nginx/html playground-docker:micronaut
```
Your front-end folder should contain an `index.html` file. A minimal alternative front-end that you can use as a starting point for developing your custom front-end is available in the `miniground` folder of [this repository](miniground).

Alternatively, you may want to use the [Docker image for the Micronaut-based backend](https://github.com/epsilonlabs/playground-micronaut/pkgs/container/playground-micronaut) directly, without using this image.
