#
# iRODS Provider Image for 4.2.10
#
FROM ubuntu:bionic

# Install pre-requisites
# tzone bug with it not seeming to respect noninteractive
# https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/London \
    apt-get install -y \
    apt-transport-https=1.6.14 \
    curl=7.58.0-2ubuntu3.16 \
    git=1:2.17.1-1ubuntu0.9 \
    ispell=3.4.00-6 \
    less=487-0.1 \
    libfuse2=2.9.7-1ubuntu1 \
    lsb-release=9.20170808ubuntu1 \
    netcat=1.10-41.1 \
    postgresql=10+190ubuntu0.1 \
    python-pip=9.0.1-2.3~ubuntu1.18.04.5  \
    rsyslog=8.32.0-1ubuntu4 \
    sudo=1.8.21p2-3ubuntu1.4 \
    unixodbc=2.3.4-1.1ubuntu3 \
    vim=2:8.0.1453-1ubuntu1.8 \
    wget=1.19.4-1ubuntu2.2 \
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
