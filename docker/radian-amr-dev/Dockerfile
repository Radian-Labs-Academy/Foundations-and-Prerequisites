# radian-amr-dev — the Radian Labs AMR development image.
#
# Prepared in Foundations (Lesson 1.8) and REUSED as the base environment in
# later courses: their lessons start `FROM radian-amr-dev` (or `docker run
# radian-amr-dev`) instead of stock ros:jazzy, so nothing has to be reinstalled.
#
# Build from the repo root so the COPY below can see radian_helpers.sh:
#   docker build -f docker/radian-amr-dev/Dockerfile -t radian-amr-dev .
FROM ros:jazzy

# Tools every Radian Labs course assumes are already present.
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3-colcon-common-extensions \
      clangd \
      tmux \
      git \
      vim \
      nano \
      less \
      iproute2 \
      iputils-ping \
  && rm -rf /var/lib/apt/lists/*

# Bake in the Radian Labs shell shortcuts (from Lesson 1.7).
COPY reference/module-01-linux/lesson-07-tmux-shell/radian_helpers.sh /etc/radian/radian_helpers.sh

# Every interactive shell sources ROS2 and the helpers automatically.
RUN echo 'source /opt/ros/jazzy/setup.bash'        >> /root/.bashrc \
 && echo 'source /etc/radian/radian_helpers.sh'    >> /root/.bashrc

# Workspaces mount here in later courses.
WORKDIR /radian_ws

CMD ["bash"]
