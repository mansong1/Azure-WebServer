# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

This is a project from Udacity Azure DevOps Nanodegree - Deploying a Web Server in Azure. For this project, we will write a Packer template and a Terraform template to deploy a customisable, scalable web server and jumpbox in Azure.

### Prerequisites

Before we begin ensure the following is complete:

1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

* **vars.tf**: This file holds the values of the variables used in the template.
* **output.tf**: This file describes the settings that display after deployment.
* **main.tf**: This file contains the code of the infrastructure we will be deploying.
* **provider.tf**: This file contains the code for the terraform provider plugin.
* **webserver.json**: This file contains the packer template for building our webserver image.


### Build Packer image

az group create -n udacityImageGroup -l southuk

`./packer build webserver.json`

### Notes

* The default value of the **resource_group_name** variable is unset. Define your own value.
* The default value of the **instance_count** variable is 1. This defines the number of VMs to deploy.


### Deploy the infrastructure

1. Initialise the Terraform environment by running the following command in the directory where you cloned this repo.

`terraform plan`

The provider plug-ins download from the Terraform registry into the **.terraform** folder in the directory where we ran the command.

2. Run the following command to deploy the infrastructure to Azure.

`terraform apply`

### Clean up the environment

`terraform destroy`