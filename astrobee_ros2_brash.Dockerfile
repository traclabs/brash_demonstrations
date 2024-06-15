FROM ghcr.io/traclabs/astrobee_docker:latest-rolling-ubuntu20.04 AS astrobee_ros2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y \
  python3-pip \ 
  libnlopt-dev \
  libcereal-dev \
  libnlopt-cxx-dev \
  rapidjson-dev \
  libgraphviz-dev \
  ros-rolling-image-view \
  libdwarf-dev \
  libelf-dev \
  libsqlite3-dev \
  sqlitebrowser \
 && rm -rf /var/lib/apt/lists/*

# Pymongo (bson) and tornado are for running the bridge_server
RUN pip3 install pymongo tornado

# Switch to bash shell
SHELL ["/bin/bash", "-c"]

# Create a brash user
ENV USERNAME=traclabs_user
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
&& chown -R ${USER_UID}:${USER_GID} ${CODE_DIR} \
&& chown -R ${USER_UID}:${USER_GID} /src/astrobee 

# Set user
USER ${USERNAME}
WORKDIR ${CODE_DIR}

# Set up sourcing
COPY --chown=${USERNAME}:${USERNAME} config/brash_astrobee_entrypoint.sh ${CODE_DIR}/entrypoint.sh
RUN echo 'source ${CODE_DIR}/entrypoint.sh' >> ~/.bashrc

RUN mkdir -p ${CODE_DIR}/brash && mkdir -p ${CODE_DIR}/juicer && mkdir -p ${CODE_DIR}/openmct_ros


# Install nodejs for openmct
RUN curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh \
  && chmod 500 nsolid_setup_deb.sh \
  && sudo ./nsolid_setup_deb.sh 18 \
  && sudo apt-get install -y nodejs


# Make workspace brash
WORKDIR ${CODE_DIR}/brash
