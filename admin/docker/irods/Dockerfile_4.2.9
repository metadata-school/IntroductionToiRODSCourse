#
# iRODS Provider Image for 4.2.9
#
FROM ubuntu:18.04

# Install pre-requisites
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y sudo wget lsb-release apt-transport-https postgresql vim python-pip libfuse2 unixodbc rsyslog less netcat git && \
    pip install xmlrunner

# Setup catalog database
COPY db_commands.txt /
RUN service postgresql start && su - postgres -c 'psql -f /db_commands.txt'

# Clone Training Repository
RUN mkdir -p /training; cd /training; git clone https://github.com/metadata-school/IntroductionToiRODSCourse.git

# Install iRODS
RUN wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add -; \
    echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list; \
    apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -y irods-runtime=4.2.9 irods-icommands=4.2.9 irods-server=4.2.9 irods-database-plugin-postgres=4.2.9
COPY configure_users.py /var/lib/irods/scripts/

EXPOSE 1248 1247

# Set command to execute when launching the container.
COPY start_provider.sh /
RUN chmod u+x /start_provider.sh
ENTRYPOINT ["./start_provider.sh"]
