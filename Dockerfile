# Open Monitoring Distribution
#
#
## Version: 0.2
FROM centos:7
MAINTAINER Nhan Pham T., phamthanhnhan14@gmail.com

# Make sure package repository is up to date
RUN yum -y update &&\
    yum clean all
RUN yum install -y epel-release

# Install check-mk-raw 
RUN yum install -y https://mathias-kettner.de/support/1.5.0p7/check-mk-raw-1.5.0p7-el7-38.x86_64.rpm
# Set up a default site
RUN omd create monitoring
# We don't want TMPFS as it requires higher privileges
RUN omd config monitoring set TMPFS off
# Accept connections on any IP address, since we get a random one
RUN omd config monitoring set APACHE_TCP_ADDR 0.0.0.0

# Add watchdog script
ADD entrypoint.sh /entrypoint.sh

# Set up runtime options
EXPOSE 5000
ENTRYPOINT ["/entrypoint.sh"]
