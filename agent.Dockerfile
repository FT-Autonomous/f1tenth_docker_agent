# Base image
FROM ros:melodic-robot-bionic

# Update apt repo and pip2, and install python3, pip3
RUN apt-get update --fix-missing && \
    apt-get install -y python-pip \
                       python3-dev \
                       python3-pip

# Install apt dependencies, add your apt dependencies to this list
RUN apt-get install -y git \
                       build-essential \
                       cmake \
                       vim \
                       ros-melodic-ackermann-msgs \
                       ros-melodic-genpy

# Upgrade pip
# RUN pip install --upgrade pip

# Install pip dependencies, add your pip dependencies to this list
RUN pip install numpy==1.16.0 \
                scipy==1.2.0 \
                pyyaml
# RUN pip3 install numpy==1.16.0 \
#                  scipy==1.2.0 \
#                  pyyaml

# Creating a catkin workspace
RUN mkdir -p /catkin_ws/src

# Clone or copy over your source code

# Copying
#COPY ./disp_ext /catkin_ws/src/

# Cloning & Replace disp_ext.py with my local copy (subverts f1tenth_gym_ros error, while allowing me to locally change code)
# RUN cd /catkin_ws/src/ && rm -rf disp_ext
# RUN cd /catkin_ws/src/ && \
#     git clone https://github.com/FT-Autonomous/disp_ext.git && cd disp_ext/scripts && rm -rf disp_ext.py
# COPY ./disp_ext/scripts/disp_ext.py /catkin_ws/src/disp_ext/scripts


#Removes git cache, redownloads repo & adds permission to .py file
RUN cd /catkin_ws/src/ && rm -rf disp_ext
RUN cd /catkin_ws/src/ && \
   git clone https://github.com/FT-Autonomous/disp_ext.git && cd disp_ext/scripts && chmod +x #disp_ext.py

# Building your ROS packages
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash; cd catkin_ws; catkin_make; source devel/setup.bash"

# Uncomment set the shell to bash to provide the "source" command
SHELL ["/bin/bash", "-c"] 

# Setting entry point command that runs when the container is brought up
CMD source /catkin_ws/devel/setup.bash; roslaunch --wait disp_ext disp_ext.launch
