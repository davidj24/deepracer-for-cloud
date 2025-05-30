# DeepRacer-For-Cloud
Provides a quick and easy way to get up and running with a DeepRacer training environment using a cloud virtual machine or a local compter, such [AWS EC2 Accelerated Computing instances](https://aws.amazon.com/ec2/instance-types/?nc1=h_ls#Accelerated_Computing) or the Azure [N-Series Virtual Machines](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-gpu).

DRfC runs on Ubuntu 20.04, 22.04 and 24.04. GPU acceleration requires a NVIDIA GPU, preferrably with more than 8GB of VRAM.

## Introduction

DeepRacer-For-Cloud (DRfC) started as an extension of the work done by Alex (https://github.com/alexschultz/deepracer-for-dummies), which is again a wrapper around the amazing work done by Chris (https://github.com/crr0004/deepracer). With the introduction of the second generation Deepracer Console the repository has been split up. This repository contains the scripts needed to *run* the training, but depends on Docker Hub to provide pre-built docker images. All the under-the-hood building capabilities are in the [Deepracer Simapp](https://github.com/aws-deepracer-community/deepracer-simapp) repository.

## Main Features

DRfC supports a wide set of features to ensure that you can focus on creating the best model:
* User-friendly
	* Based on the continously updated community [Robomaker](https://github.com/aws-deepracer-community/deepracer-simapp) container, supporting a wide range of CPU and GPU setups.
	* Wide set of scripts (`dr-*`) enables effortless training.
	* Detection of your AWS DeepRacer Console models; allows upload of a locally trained model to any of them.
* Modes
	* Time Trial
	* Object Avoidance
	* Head-to-Bot
* Training
	* Multiple Robomaker instances per Sagemaker (N:1) to improve training progress.
	* Multiple training sessions in parallel - each being (N:1) if hardware supports it - to test out things in parallel.
	* Connect multiple nodes together (Swarm-mode only) to combine the powers of multiple computers/instances.
* Evaluation
	* Evaluate independently from training.
	* Save evaluation run to MP4 file in S3.
* Logging
	* Training metrics and trace files are stored to S3.
	* Optional integration with AWS CloudWatch.
	* Optional exposure of Robomaker internal log-files.
* Technology
	* Supports both Docker Swarm (used for connecting multiple nodes together) and Docker Compose

## Documentation

Full documentation can be found on the [Deepracer-for-Cloud GitHub Pages](https://aws-deepracer-community.github.io/deepracer-for-cloud).

## Support

* For general support it is suggested to join the [AWS DeepRacing Community](https://deepracing.io/). The Community Slack has a channel #dr-training-local where the community provides active support.
* Create a GitHub issue if you find an actual code issue, or where updates to documentation would be required.
