################################################
# Build ros-base                               #
# (ROS2 image with default packages)           #
################################################
FROM ghcr.io/traclabs/spaceros_robots AS spaceros-base
ENV DEBIAN_FRONTEND=noninteractive

# Install CFDP for large file transfer
RUN pip3 install cfdp

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
WORKDIR ${CODE_DIR}/brash

##################################################
# Build brash (Production)                       #
##################################################
FROM spaceros-brash-dev AS spaceros-brash

# Copy brash
COPY --chown=${USERNAME}:${USERNAME} brash ${CODE_DIR}/brash

# Build the brash workspace
WORKDIR ${CODE_DIR}/brash
RUN source ${CODE_DIR}/demo_extras_ws/install/setup.bash &&  \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# Build juicer
COPY --chown=${USERNAME}:${USERNAME} juicer ${CODE_DIR}/juicer
WORKDIR ${CODE_DIR}/juicer
RUN  make

# Set workspace
WORKDIR ${CODE_DIR}/brash


