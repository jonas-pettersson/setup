# Setup AWS instance for 2018 edition of fastai deep learning course
http://course.fast.ai/

## Credits
The script i based on the [Paperspace setup script](http://files.fast.ai/setup/paperspace) from the course
with very minor adaptations.

## What it tries to do
The script installs all needed to get started with lesson 1 of the fastai deep learning course of 2018.
It is intended for setup on a fresh ubuntu machine, for example on AWS Ubuntu Server 16.04 LTS (HVM).
It was tested on the AWS AMI *ami-c7e0c82c.*

## What it does
This is the setup for the second edition of the course which is based on pytorch.
The script installs NVIDIA CUDA, NVIDIA CUDNN, and Anaconda (Python 3.5).
It then clones the [fastai](https://github.com/fastai/fastai) library from GitHub and
installs all conda packages needed (included pytorch) as defined in the [environment yml](https://github.com/fastai/fastai/blob/master/environment.yml).
Finally it downloads the data for the first example ([Cats and Dogs Kaggle competition](https://www.kaggle.com/c/dogs-vs-cats)
and configures Jupyter Notebook

## Usage
1. 
