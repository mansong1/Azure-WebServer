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

1. Create a resource group with az group create: `az group create -n udacityImageGroup -l uksouth`

<<<<<<< HEAD
```
=======
`
>>>>>>> fa24557ac2e30223315734eb38286f4842056c50
{
  "id": "/subscriptions/b8acf670-45b1-4124-b6ce-a294c1583634/resourceGroups/udacityImageGroup",
  "location": "uksouth",
  "managedBy": null,
  "name": "udacityImageGroup",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
<<<<<<< HEAD
```

2. Create a service principal with az ad sp create-for-rbac and output the credentials that Packer needs:

```
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
az account show --query "{ subscription_id: id }"
```

```
=======
`

2. Create a service principal with az ad sp create-for-rbac and output the credentials that Packer needs:
`
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
az account show --query "{ subscription_id: id }"
`
`
>>>>>>> fa24557ac2e30223315734eb38286f4842056c50
export ARM_SUBSCRIPTION_ID=your_subscription_id
export ARM_CLIENT_ID=your_appId
export ARM_CLIENT_SECRET=your_password
export ARM_TENANT_ID=your_tenant_id
<<<<<<< HEAD
```

=======
`
>>>>>>> fa24557ac2e30223315734eb38286f4842056c50
3. Build Image

`packer build webserver.json`

### Deploy the infrastructure

1. Initialise the Terraform environment by running the following command in the directory where you cloned this repo.

`terrafrom init`

The provider plug-ins download from the Terraform registry into the **.terraform** folder in the directory where we ran the command.

2. Run the following command to deploy the infrastructure to Azure.

#### N.B.

* The default value of the **resource_group_name** variable is unset. Define your own value.
* The default value of the **instance_count** variable is 1. This defines the number of VMs to deploy.

Either update the vars.tf or pass a var as below:

`terraform plan -out -var="resource_group_name=udacity"` - See solution.plan for what this outputs

`terraform apply solution.plan`

### Clean up the environment

`terraform destroy`

### Optional - Deploy a policy

We can create a policy that ensures all indexed resources are tagged. This will help us with organization and tracking, and make it easier to log when things go wrong.

```
az policy definition create --name 'tagging-policy' --display-name 'Add a tag to resources' --description 'Prevents the creation of any resource missing a tag.' --rules 'tagpolicy.rules.json' --mode Indexed
```

```
az policy assignment create --name "tagging-policy" --scope "/subscriptions/<ACCOUNTID>" --policy "tagging-policy"
```

The ACCOUNTID can be found by running the below command: 

```
az account show --query "{ subscription_id: id }"
```

az account list and looking up id in the fields.

Check the policy by running `az policy assignment list`
