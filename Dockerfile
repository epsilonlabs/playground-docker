FROM    ubuntu

# Install python3
RUN     apt-get update
RUN     apt-get install -y python3

# Install Maven
RUN     apt-get install -y maven

# Install Git
RUN     apt-get install -y git

# Clone the Epsilon Playground repo
RUN git clone --depth=1 https://github.com/epsilonlabs/playground

# WORKDIR /playground
# RUN mvn install

# Clone the Epsilon website repo
RUN git clone --depth=1 https://git.eclipse.org/r/www.eclipse.org/epsilon.git

# Copy html
# ADD static/ /src
WORKDIR /epsilon

# Run http server on port 8080
EXPOSE  8080
CMD ["python3", "-m", "http.server", "8080"]