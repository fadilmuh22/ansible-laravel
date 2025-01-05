FROM ubuntu:noble

# Set the environment to specify container runtime
ENV container podman

# Install systemd, OpenSSH server, and sudo
RUN apt-get update && apt-get install -y \
    systemd \
    systemd-sysv \
    sudo \
    openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable SSH by setting up necessary directories
RUN mkdir -p /var/run/sshd

# Enable passwordless sudo for root user
RUN echo "root ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-root-nopasswd

# Configure OpenSSH server to use your SSH key and disable root login via password
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#AuthorizedKeysFile     .ssh\/authorized_keys/AuthorizedKeysFile     .ssh\/authorized_keys/' /etc/ssh/sshd_config

# Expose SSH port for internal use (no need to expose to host)
EXPOSE 22

# Set up the volume for systemd's cgroup management
VOLUME [ "/sys/fs/cgroup" ]

# Command to run systemd
CMD ["/lib/systemd/systemd"]
