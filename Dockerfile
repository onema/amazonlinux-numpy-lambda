FROM amazonlinux:2.0.20220719.0

# Build variables
ENV PYTHON_VERSION=3.9.12
ENV PYTHON_SHORT_VERSION=3.9
ENV DOWNLOAD_PATH=/tmp
ENV SERVERLESS_VERSION=3.21.0
WORKDIR $DOWNLOAD_PATH

# Install node and related tools
RUN curl --silent --location https://rpm.nodesource.com/setup_16.x | bash - \
    && yum -y install nodejs zip \
    && npm install serverless@${SERVERLESS_VERSION} -g \
    && node --version

# Install development tools required for compiling python
RUN yum -y groupinstall "Development Tools" \
    && yum -y install openssl-devel bzip2-devel libffi-devel wget \
    && gcc --version && make --version

# Get the specicfied version of python
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xvf Python-${PYTHON_VERSION}.tgz

# Install python
RUN cd Python-*/ \
    && ./configure --enable-optimizations \
    && make altinstall \
    && python${PYTHON_SHORT_VERSION} --version

# Upgrade PIP
RUN python${PYTHON_SHORT_VERSION} -m pip install --upgrade pip

# Install image helper packages
COPY files/requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Cleanup
RUN rm -rf $DOWNLOAD_PATH/Python-*

# Add volume to map to project application
VOLUME /app

CMD ["/bin/bash"]
