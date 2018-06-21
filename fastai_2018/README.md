# Setup AWS instance for 2018 edition of fastai deep learning course
http://course.fast.ai/

## Why?
You should probably first consider using [Paperspace](https://github.com/reshamas/fastai_deeplearn_part1/blob/master/tools/paperspace.md) for the fastai course, or use an AWS instance based on the existing AMI named *fastai-part1v2-p2* as described [here](https://github.com/reshamas/fastai_deeplearn_part1/blob/master/tools/aws_ami_gpu_setup.md).
I had the problem that the fastai AMI was not available in the Frankfurt AWS region (and I could not copy it).
Another use case for this script would be if you have an own machine (not AWS).

## Credits
The script i based on the [Paperspace setup script](http://files.fast.ai/setup/paperspace) from the course
with very minor adaptations.

## What it does
The script installs all needed to get started with lesson 1 of the fastai deep learning course of 2018.
It is intended for setup on a fresh ubuntu machine, for example on AWS Ubuntu Server 16.04 LTS (HVM).
It was tested on the AWS AMI *ami-c7e0c82c.*

## Prerequisites
* About 32 GiB of disk space
* A GPU (e.g. a p2.xlarge instance on AWS)
* Linux (e.g. Ubuntu Server 16.04 LTS)
* Security Profile allowing inbound traffic on port 8888 (Jupyter Notebook)

## How it works
This is the setup for the second edition of the course which is based on pytorch.
The script installs NVIDIA CUDA, NVIDIA CUDNN, and Anaconda (Python 3.5).
It then clones the [fastai](https://github.com/fastai/fastai) library from GitHub and
installs all conda packages needed (including pytorch) as defined in the [environment yml](https://github.com/fastai/fastai/blob/master/environment.yml).
Finally it downloads the data for the first example ([Cats and Dogs Kaggle competition](https://www.kaggle.com/c/dogs-vs-cats))
and configures Jupyter Notebook

## How to use it
1. Create an AWS instance (p2.xlarge, 32 GiB) and login. See for example this [description from reshamas](https://github.com/reshamas/fastai_deeplearn_part1/blob/master/tools/aws_ami_gpu_setup.md), but assuming the fastai AMI is not available, use a standard Ubuntu AMI instead.
2. ```wget https://raw.githubusercontent.com/jonas-pettersson/setup/master/fastai_2018/setup_aws_ubuntu_p2.xlarge_for_fastai_dl_2018.sh```
3. ```chmod u+x setup_aws_ubuntu_p2.xlarge_for_fastai_dl_2018.sh```
4. ```~/setup_aws_ubuntu_p2.xlarge_for_fastai_dl_2018.sh```
5. When finished: reboot
6. Login with ssh using the ```-L8888:localhost:8888``` flag, e.g. ```ssh -i .ssh/jonastest.pem ubuntu@10.141.6.162 -L8888:localhost:8888```. Now you can use localhost to connect to the 8888 port of the machine. See also the [description from reshamas](https://github.com/reshamas/fastai_deeplearn_part1/blob/master/tools/aws_ami_gpu_setup.md)
7. You can check NVIDIA status with ```nvidia-smi```
8. ```jupyter notebook```
9. Copy URL from Jupyter log and paste into your web browser, e.g. ```http://localhost:8888/?token=04089b6ccf89e723321097c9089ab52550f408c86f533608```

