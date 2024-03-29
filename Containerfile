# syntax=docker/dockerfile:1
FROM hub.opensciencegrid.org/opensciencegrid/software-base:fresh

# Docker image build arguments:
ARG VERSION=3.12.10

# Copy files in
COPY files/fetch-crl /etc/cron.d/fetch-crl
COPY files/10-fts.conf /etc/supervisor.d/
COPY files/20-fts-config.sh /etc/osg/image-config.d/
#COPY files/fts3config etc/fts3/fts3config
#COPY files/fts-msg-monitoring.conf etc/fts3/fts-msg-monitoring.conf
#COPY files/docker-entrypoint.sh tmp/docker-entrypoint.sh 

# Update the base image
RUN yum update -y
# Add various repos
ADD "http://fts-repo.web.cern.ch/fts-repo/fts3-prod-el7.repo" "/etc/yum.repos.d/"
ADD "https://fts-repo.web.cern.ch/fts-repo/fts3-depend-el7.repo" "/etc/yum.repos.d/"

RUN yum install epel-release -y
RUN yum install yum-plugin-priorities -y
RUN yum install centos-release-scl -y

# Install the FTS packages and dependencies
RUN yum install gfal2-all -y gfal2-plugin-mock
RUN yum install -y osg-ca-certs cronie crontabs supervisor fetch-crl
RUN yum install -y fts-server-$VERSION \
                   fts-client-$VERSION \
                   fts-rest-server-3.12.3 \
                   fts-monitoring-3.12.2 \
                   fts-mysql-$VERSION \
                   fts-server-selinux-$VERSION \
                   fts-rest-server-selinux-3.12.3 \
                   fts-monitoring-selinux-3.12.2 \
                   fts-msg-$VERSION \
                   fts-infosys-$VERSION
RUN yum install -y vo-client x509-scitokens-issuer-client
# Clean up
RUN yum clean all && \
    rm -rf /var/cache/yum
# Set the entrypoint to the provided supervisord starter
ENTRYPOINT ["/usr/local/sbin/supervisord_startup.sh"]
