# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction

This is a project from Udacity Azure DevOps Nanodegree - Deploying a Web Server in Azure. For this project, we will write a Packer template and a Terraform template to deploy a customisable, scalable web server in Azure.

### Prerequisites

Before we begin ensure the following is complete:

1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)


### Instructions

* vars.tf: This file holds the values of the variables used in the template.
* output.tf: This file describes the settings that display after deployment.
* main.tf: This file contains the code of the infrastructure we will be deploying.

### N.B. 

* The default value of the **resource_group_name** variable is unset. Define your own value.
* The default value of the **instance_count** variable is 1. This defines the number of VMs to deploy
