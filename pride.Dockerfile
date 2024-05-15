FROM ubuntu:jammy AS pride-dev

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get install -y \
  gdb nano cmake git pkg-config sudo \
  wget curl software-properties-common \
  build-essential g++ ant \
  subversion openjdk-11-jdk-headless \
  mysql-client mysql-server \
  gconf-service libasound2 libatk1.0-0 \
  libc6 libcairo2 libcups2 libdbus-1-3 \
  libexpat1 libfontconfig1 libgcc1 \
  libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
  libgtk-3-0 libnspr4 libpango-1.0-0 \
  libpangocairo-1.0-0 libstdc++6 libx11-6 \
  libx11-xcb1 libxcb1 libxcomposite1 \
  libxcursor1 libxdamage1 libxext6 \
  libxfixes3 libxi6 libxrandr2 \
  libxrender1 libxss1 libxtst6 \
  ca-certificates fonts-liberation libappindicator1 \
  libnss3 lsb-release xdg-utils wget \
  && rm -rf /var/lib/apt/lists/*

# Switch to bash shell
SHELL ["/bin/bash", "-c"]

# Create a brash user
ENV USERNAME pride_user
ENV HOME_DIR=/home/${USERNAME}
ENV CODE_DIR=/code

# Dev container arguments
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

# Create new user and home directory
RUN groupadd --gid ${USER_GID} ${USERNAME} \
&& useradd --uid ${USER_UID} --gid ${USER_GID} --create-home ${USERNAME} \
&& echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
&& chmod 0440 /etc/sudoers.d/${USERNAME} \
&& mkdir -p ${CODE_DIR} \
&& chown -R ${USER_UID}:${USER_GID} ${CODE_DIR}

# Swith to username
USER ${USERNAME}
WORKDIR ${CODE_DIR}

# Install nodejs
RUN curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh \
  && chmod 500 nsolid_setup_deb.sh \
  && sudo ./nsolid_setup_deb.sh 18 \
  && sudo apt-get install -y nodejs


# Copy temporally a few files needed for mysql setup
COPY --chown=${USERNAME}:${USERNAME} ./pride/view/code/mysql.init ./mysql.init
COPY --chown=${USERNAME}:${USERNAME} ./pride/view/code/etc/mysql ./etc/mysql

# Start mysql and then setup mysql for Pride
RUN  sudo service mysql start && sudo mysql -u root --password="" < mysql.init

# Delete the temporal files
RUN rm ./mysql.init && rm -rf ./etc/mysql


# Set workdir
WORKDIR ${CODE_DIR}/pride


