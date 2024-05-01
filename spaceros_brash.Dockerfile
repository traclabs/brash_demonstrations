################################################
# Build ros-base                               #
# (ROS2 image with default packages)           #
################################################
FROM ghcr.io/traclabs/spaceros_robots:latest AS spaceros-base
ENV DEBIAN_FRONTEND=noninteractive

# Install CFDP for large file transfer
# Pymongo (bson) and tornado are for running the bridge_server
# which is needed only for demos that run the OpenMCTROS plugin
RUN pip3 install cfdp pymongo tornado

# Switch to bash shell
SHELL ["/bin/bash", "-c"]

# Use username already available/created in spaceros-robots docker
USER ${USERNAME}
ENV CODE_DIR=/code

################################################
# Build spaceros-brash-dev                     #
################################################

FROM spaceros-base AS spaceros-brash-dev
ENV DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get install -y \
  libdwarf-dev \
  libelf-dev \
  libsqlite3-dev \
  sqlitebrowser

# Install additional packages for demos (rqt / steering plugin)
RUN sudo mkdir -p ${CODE_DIR} && \
   sudo chown -R ${USERNAME}:${USERNAME} ${CODE_DIR}
RUN mkdir -p ${CODE_DIR}/demo_extras_ws   
WORKDIR ${CODE_DIR}/demo_extras_ws
COPY --chown=${USERNAME}:${USERNAME} ./config/demo_extra_pkgs.repos demo_extra_pkgs.repos

RUN mkdir src && vcs import src < demo_extra_pkgs.repos 
RUN source ${HOME_DIR}/spaceros_robots_ws/install/setup.bash &&  \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release


# Set up sourcing
COPY --chown=${USERNAME}:${USERNAME} config/brash_entrypoint.sh ${CODE_DIR}/entrypoint.sh
RUN echo 'source ${CODE_DIR}/entrypoint.sh' >> ~/.bashrc

# Get ready with brash workspace
RUN mkdir -p ${CODE_DIR}/brash

# Create folder for juicer
RUN mkdir -p ${CODE_DIR}/juicer

# Make workspace brash
WORKDIR ${CODE_DIR}/brash
