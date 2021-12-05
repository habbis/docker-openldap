FROM debian:unstable-slim
LABEL maintainer="Eirik Habbestad"

#ENV SERVICE slapd
ARG DEBIAN_FRONTEND=noninteractive
ARG LDAP_PASSWORD
ARG BASE_DN
# Install dependencies.
RUN apt-get update \
    #&& apt-get install -y --no-install-recommends \
    && apt-get install -y \
        slapd  \
	ldap-utils \
       rsyslog systemd systemd-cron sudo iproute2 \
    && apt-get clean \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf
# Fix potential UTF-8 errors with ansible-test.
#RUN locale-gen en_US.UTF-8
COPY initctl_faker .
COPY base.ldif /tmp/
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl
# Remove unnecessary getty and udev targets that result in high CPU usage when using
# multiple containers with Molecule (https://github.com/ansible/molecule/issues/1104)
RUN rm -f /lib/systemd/system/systemd*udev* \
  && rm -f /lib/systemd/system/getty.target
# set ldap admin password
RUN slappasswd -s $LDAP_PASSWORD
EXPOSE 389 636
VOLUME ["/etc/ldap" , "/var/lib/ldap" , "/usr/lib/ldap" ]
RUN /sbin/initctl start slapd \
	service slapd start
RUN ldapadd -x -D $BASE_DN -w $LDAP_PASSWORD -f /tmp/base.ldif
