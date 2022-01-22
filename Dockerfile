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
    && apt-get install -y python3-minimal \
    && rm -rf /var/lib/apt/lists/*

COPY --from=git_clones /playground/ /playground/
COPY --from=git_clones /epsilon/ /epsilon/

WORKDIR /playground

# Due to https://issues.apache.org/jira/browse/MDEP-568, m-dependency-p
# is not a practical solution for ensuring all dependencies are available.
#
# We use https://github.com/qaware/go-offline-maven-plugin instead.
RUN mvn -B de.qaware.maven:go-offline-maven-plugin:1.2.8:resolve-dependencies

# Copy start script and make it executable
ADD start.sh /
RUN chmod +x /start.sh

# Copy backend.json
ADD backend.json /epsilon/mkdocs/docs/live

ENTRYPOINT ["/start.sh"]