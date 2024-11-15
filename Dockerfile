FROM bitnami/git AS git_clones

# Clone the Epsilon Playground repo that contains the back-end
RUN git clone --depth=1 https://github.com/epsilonlabs/playground

# Clone the Epsilon website repo that contains the front-end
RUN git clone --depth=1 https://github.com/eclipse/epsilon-website epsilon

FROM nginx:latest AS webapp

# Needed to avoid prompts blocking the build process
ENV DEBIAN_FRONTEND=noninteractive

# Needed for Cloud Build
ENV PORT=80

# Install Python
RUN apt-get update \
    && apt-get install -y python3-minimal maven tini netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

# Copy playground sources
COPY --from=git_clones /playground/ /playground/
COPY --from=git_clones /epsilon/mkdocs/docs/playground/ /etc/nginx/html/

# Redirect /services/ URLs to the backend services running on ports 8001-8003
ADD ./nginx.conf.template /etc/nginx.conf.template

WORKDIR /playground

# Build fat jar with all services and dependencies
RUN mvn package

# Copy start script and make it executable
ADD start.sh /
RUN chmod +x /start.sh

# Copy backend.json
ADD backend.json /etc/nginx/html/

ENTRYPOINT ["/usr/bin/tini", "--", "/start.sh"]
