# Use the base Ubuntu 18.04 image
FROM ubuntu:18.04

# Set non-interactive mode for tzdata configuration
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists
RUN apt-get update

# Install necessary packages, including tzdata
RUN apt-get install -y sudo tzdata

# Manually set the time zone to Chicago
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime \
    && echo "America/Chicago" > /etc/timezone

RUN apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat cpio python3 python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev pylint3 xterm python3-subunit mesa-common-dev -y

# Install necessary packages
RUN apt-get install -y openssh-server locales

# Generate and set en_US.UTF-8 locale
RUN locale-gen en_US.UTF-8 \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Create a new user called 'dockeruser' with a password 'dockerpassword'
RUN useradd -ms /bin/bash dockeruser \
    && echo "dockeruser:pass" | chpasswd \
    && adduser dockeruser sudo

# Set up SSH directories
RUN mkdir /var/run/sshd

# Switch to the new user
USER dockeruser

# Set the working directory to the user's home directory
WORKDIR /home/dockeruser

# Run bash by default
CMD ["/bin/bash"]
