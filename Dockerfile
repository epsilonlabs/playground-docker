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

# Clone the Epsilon website repo
RUN git clone --depth=1 https://git.eclipse.org/r/www.eclipse.org/epsilon.git

# Copy start script and make it executable
ADD start.sh .
RUN chmod +x start.sh

# Copy backend.json
ADD backend.json /epsilon/live

WORKDIR /playground
ADD pom.xml .
RUN mvn install

# WORKDIR ../epsilon

# Run http server on port 8000
EXPOSE  8000
CMD ../start.sh