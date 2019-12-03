FROM amazonlinux:2.0.20191016.0

# Install node and related tools
RUN curl --silent --location https://rpm.nodesource.com/setup_10.x | bash - \
    && yum -y install nodejs
RUN node --version

# Install python 3.7 and development tools
RUN yum -y install python3
RUN python3 --version

# Create env directory
RUN mkdir ~/env
WORKDIR ~/env
COPY files/requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Add volume to map to project application
VOLUME /app

CMD ["/bin/bash"]
