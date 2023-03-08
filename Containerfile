FROM hub.opensciencegrid.org/opensciencegrid/software-base:fresh

# Labels
LABEL io.slateci.image.name="fts-server"
LABEL io.slateci.image.tags="3.12.5"
LABEL org.opencontainers.image.authors="lincolnb@uchicago.edu"
LABEL org.opencontainers.image.description="File Transfer Service from CERN"
LABEL org.opencontainers.image.licenses="Apache 2.0"
LABEL org.opencontainers.image.title="File Transfer Service - 3"
LABEL org.opencontainers.image.url="https://github.com/slateci/container-fts-server"
LABEL org.opencontainers.image.vendor="SLATECI"
LABEL org.opencontainers.image.version="3.12.5"

ARG VERSION=3.12.5

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

# FIXME: Drop this once gfal2 2.21.3 is available in EPEL
# Add the DMC repo but make it disabled by default lest it conflict with OSG/EPEL
ADD "https://dmc-repo.web.cern.ch/dmc-repo/dmc-rc-el7.repo" "/etc/yum.repos.d/"
RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/dmc-rc-el7.repo

# FTS release candidate repo - disabled
#ADD "http://fts-repo.web.cern.ch/fts-repo/fts3-rc-el7.repo" "/etc/yum.repos.d/"

RUN yum install epel-release -y
RUN yum install yum-plugin-priorities -y
RUN yum install centos-release-scl -y

# Install the FTS packages and dependencies
RUN yum install --enablerepo=dmc-rc-el7 gfal2-all-2.21.3 -y gfal2-plugin-mock
#RUN yum install gfal2-all -y gfal2-plugin-mock
RUN yum install -y osg-ca-certs cronie crontabs supervisor fetch-crl
RUN yum install -y fts-server-$VERSION \
                   fts-client-$VERSION \
                   fts-rest-server-3.12.1 \
                   fts-monitoring-3.12.1 \
                   fts-mysql-$VERSION \
                   fts-server-selinux-$VERSION \
                   fts-rest-server-selinux-3.12.1 \
                   fts-monitoring-selinux-3.12.1 \
                   fts-msg-$VERSION \
                   fts-infosys-$VERSION
RUN yum install -y vo-client x509-scitokens-issuer-client
# Clean up
RUN yum clean all && \
    rm -rf /var/cache/yum
# Set the entrypoint to the provided supervisord starter
ENTRYPOINT ["/usr/local/sbin/supervisord_startup.sh"]
