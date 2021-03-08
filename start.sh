#!/bin/bash
if [ ! -d f1tenth_gym ] ; then
    git clone https://github.com/f1tenth/f1tenth_gym
    cd f1tenth_gym
    git checkout cpp_backend_archive
    cd ..
else
    echo f1tenth_gym exists, not cloning, pulling in latest updates.
    cd f1tenth_gym
    git checkout cpp_backend_archive
    git pull
    cd ..
fi

if [ ! -d f1tenth_gym_ros ] ; then
    git clone https://github.com/f1tenth/f1tenth_gym_ros
    cd f1tenth_gym_ros
    git checkout docker_agent
    cd ..
else
    echo f1tenth_gym_ros exists, not cloning, pulling in latest updates.
    cd f1tenth_gym_ros
    git checkout docker_agent
    git pull
    cd ..
fi

if [ ! -d disp_ext ] ; then
    git clone https://github.com/FT_Autonomous/disp_ext.git
else
    echo disp_ext exists, not cloning, pulling in latest updates.
    cd disp_ext
    git pull
    cd ..
fi

docker-compose up --build

