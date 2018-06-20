#!/usr/bin/env bash

#============================================================
#    FILE:  setup_aws_ubuntu_p2.xlarge_for_fastai_dl_2018
#
#    BASED ON:  http://files.fast.ai/setup/paperspace
#    ALTERNATIVE: https://github.com/radekosmulski/courses/blob/master/setup/install-gpu-part1-v2-cuda8.sh
#
#    USAGE:  ~/setup_aws_ubuntu_p2.xlarge_for_fastai_dl_2018
#
#    DESCRIPTION: Installs all needed for fastai deep learning course of 2018 
#                 on a fresh ubuntu machine, for example on AWS Ubuntu Server 16.04 LTS (HVM),
#                 ami-c7e0c82c (tested only on this).
#                 This is the setup for the second edition of the course which
#                 is based on pytorch. The original script was for setup on https://www.paperspace.com/
#
#                 1) Install NVIDIA CUDA
#                 2) Install NVIDIA CUDNN
#                 3) Install Anaconda for Python 3.5
#                 4) Clone fastai from GitHub
#                 5) Install all conda packages (see fastai/environment.yml)
#                 6) Download data for Cats and Dogs Kaggle competition
#                 7) Configure Jupyter Notebook
#
#    PREREQUISITES:
#    - Linux / Ubuntu
#
#    PLEASE NOTE:
#    - some things like qt-tools are probably not needed but didn't remove them yet
#
#    AUTHOR:  Jonas Pettersson, j.g.f.pettersson@gmail.com
#    CREATED: 20/06/2018
#============================================================

set -e
set -o xtrace
DEBIAN_FRONTEND=noninteractive

# Preparation
sudo rm -rf /etc/apt/apt.conf.d/*
sudo apt update
sudo apt install unzip -y
sudo apt -y upgrade --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
sudo apt -y autoremove

sudo ufw allow 8888:8898/tcp

# Probably not needed (?)
# sudo apt -y install --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" qtdeclarative5-dev qml-module-qtquick-controls
# sudo add-apt-repository ppa:graphics-drivers/ppa -y

sudo apt update

# Install NVIDIA CUDA
mkdir -p downloads
cd ~/downloads/
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo apt update
sudo apt install cuda -y

# Install NVIDIA CUDNN
wget http://files.fast.ai/files/cudnn-9.1-linux-x64-v7.tgz
tar xf cudnn-9.1-linux-x64-v7.tgz
sudo cp cuda/include/*.* /usr/local/cuda/include/
sudo cp cuda/lib64/*.* /usr/local/cuda/lib64/

# Install Anaconda for Python 3.5
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
bash Anaconda3-5.0.1-Linux-x86_64.sh -b -u

# Clone fastai from GitHub
cd
if [ ! -d "fastai" ] ; then
    git clone https://github.com/fastai/fastai.git
fi
cd fastai/

echo 'export PATH=~/anaconda3/bin:$PATH' >> ~/.bashrc
export PATH=~/anaconda3/bin:$PATH
source ~/.bashrc

# Install all conda packages (see fastai/environment.yml)
conda env update
echo 'source activate fastai' >> ~/.bashrc
source activate fastai
source ~/.bashrc

# Download data for Cats and Dogs Kaggle competition
cd ..
mkdir -p data
cd data
wget http://files.fast.ai/data/dogscats.zip
unzip -q dogscats.zip
cd ../fastai/courses/dl1/
ln -s ~/data ./

# Configure Jupyter Notebook
jupyter notebook --generate-config
echo "c.NotebookApp.ip = '*'" >> ~/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
sudo apt install -y python-pip
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension --sys-prefix

# Cleanup: remove large files
sudo rm -rf downloads/*
sudo rm -f fastai/data/dogscats.zip

# Optional: Install Kaggle CLI (cliff needed for kaggle-cli)
pip install --upgrade cliff
pip install kaggle-cli

echo
echo ---
echo - YOU NEED TO REBOOT YOUR COMPUTER NOW
echo ---
