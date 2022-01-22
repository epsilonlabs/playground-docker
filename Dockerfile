FROM bitnami/git AS git_clones

# Clone the Epsilon Playground repo
RUN git clone --depth=1 https://github.com/epsilonlabs/playground

# Clone the Epsilon website repo
RUN git clone --depth=1 https://git.eclipse.org/r/www.eclipse.org/epsilon.git

FROM maven:3-jdk-11-slim AS webapp

# Needed to avoid prompts blocking the build process
ENV DEBIAN_FRONTEND=noninteractive

# Install Python
RUN apt-get update \
    && apt-get install -y python3 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=git_clones /playground/ /playground/
COPY --from=git_clones /epsilon/ /epsilon/

# Copy start script and make it executable
ADD start.sh .
RUN chmod +x start.sh

# Copy backend.json
ADD backend.json /epsilon/mkdocs/docs/live

WORKDIR /playground
RUN mvn dependency:go-offline

# Run http server on port 8000 and services in ports 8001-8003
EXPOSE  8000
EXPOSE  8001
EXPOSE  8002
EXPOSE  8003

# ENTRYPOINT ["/start.sh"]
CMD ../start.sh