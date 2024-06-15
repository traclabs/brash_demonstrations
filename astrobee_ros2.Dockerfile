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

USER ${USERNAME}
RUN mkdir ${CODE_DIR}/rosws
WORKDIR ${CODE_DIR}/rosws



