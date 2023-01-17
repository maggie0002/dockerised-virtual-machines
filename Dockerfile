# Ubuntu 18.04 required to run libvirt with `service`, which is required by Vagrant. Newer 
# ubuntu versions are incompatible with `service` by default
FROM ubuntu:18.04

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
    apt-get install -y \
    libvirt-daemon-system \
    libvirt-dev \
    net-tools \
    openssh-server \
    qemu-kvm \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Sets the default for all commands executed inside the container
ENV VAGRANT_DEFAULT_PROVIDER=libvirt

# Install Vagrant from source. Version from the Ubuntu repo does not contain required plugins
ARG VAGRANT_URL="https://releases.hashicorp.com/vagrant/2.3.4/vagrant_2.3.4-1_amd64.deb"

RUN wget -O vagrant.deb $VAGRANT_URL && \
    dpkg -i vagrant.deb && \
    rm vagrant.deb

RUN vagrant plugin install vagrant-libvirt

# Defaults to a Ubuntu box. Override these ARGS with --build-arg to use a different box
ARG PROVIDER="peru/ubuntu-20.04-desktop-amd64"
ARG VAGRANT_FILE="peru-ubuntu-20.04-desktop-amd64"

RUN vagrant box add --provider libvirt $PROVIDER
RUN vagrant init $PROVIDER

COPY ${VAGRANT_FILE} Vagrantfile 
COPY start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["/app/start.sh"]

CMD ["sleep", "infinity"]
