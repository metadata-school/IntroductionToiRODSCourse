#
# iRODS Provider Image for 4.2.10
#
FROM ubuntu:18.04

# Install pre-requisites
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y \
    apt-transport-https \
    curl \
    git \
    ispell \
    less \
    libfuse2 \
    lsb-release \
    netcat \
    postgresql \
    python-pip \
    rsyslog \
    sudo \
    unixodbc \
    vim \
    wget \
    && pip install --no-cache-dir xmlrunner==1.7.7  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Setup catalog database
COPY db_commands.txt /
RUN service postgresql start && su - postgres -c 'psql -f /db_commands.txt'

# Clone Training Repository
RUN mkdir -p /training; git clone https://github.com/metadata-school/IntroductionToiRODSCourse.git /training

# copy training user setup stuff
COPY adduser.local /usr/local/sbin/
COPY users.txt /

# Install iRODS
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -; \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list;
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y irods-runtime=4.2.10 irods-icommands=4.2.10 irods-server=4.2.10 irods-database-plugin-postgres=4.2.10  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY configure_users.py /var/lib/irods/scripts/

# Install Python Modules
RUN pip install --no-cache-dir --upgrade pip==20.3.4; pip install --no-cache-dir python-irodsclient==0.8.5

EXPOSE 1248 1247

# Set command to execute when launching the container.
COPY start_provider.sh /
RUN chmod u+x /start_provider.sh
ENTRYPOINT ["./start_provider.sh"]
