# Terraspace Azure AKS Cluster Example

This project shows how to use the [Azure AKS Terraform registry module](https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google) with [Terraspace](https://terraspace.cloud/).

* Thanks and credit goes to the author of this module: Eric J.
* Most contributors are doing this on their own free time. Please support them. Contribute back and send them a pull request. Some may ask for donations. Donate to them. Some are consultants. Hire them.

## Setup

    git clone https://github.com/boltops-tools/terraspace-azurerm-aks
    cd terraspace-azurerm-aks
    bundle

## Deploy Cluster

Make sure the `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET` env variables are set:

Terraspace Docs: [Configure Azure](https://terraspace.cloud/docs/learn/azure/configure/)

You also want to set your region.

    az configure --defaults location=eastus

Then create a tfvars file to set variables. Change the values to your specific setup. These are only examples:

app/stacks/aks/tfvars/dev.tfvars:

    resource_group_name = "demo-resources"
    vnet_subnet_id      = "/subscriptions/<%= AzureInfo.subscription_id %>/resourceGroups/demo-resources/providers/Microsoft.Network/virtualNetworks/network-dev/subnets/subnet1"

Then to deploy:

    terraspace up aks

An aks cluster with a friendly random named is created.

## Connecting to the Cluster

    $ az aks list | jq -r '.[].name'
    frank-gull-aks
    $ az aks get-credentials --resource-group demo-resources --name frank-gull-aks
    Merged "frank-gull-aks" as current context in /home/ec2-user/.kube/config
    $ kubectl get node
    NAME                               STATUS   ROLES   AGE    VERSION
    aks-nodepool-29661280-vmss000000   Ready    agent   9m     v1.17.11
    aks-nodepool-29661280-vmss000001   Ready    agent   9m2s   v1.17.11
    $

Azure Docs: [Connect to the cluster](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)

## Create App

To create and deploy a Kubernetes app onto the cluster check out: [Kubes: Kubernetes Deployment Tool](https://kubes.guru/)

## Updating

To update the modules to the latest version from the Terraform registry.

    terraspace bundle update

Then recreate a tfvars file at `app/stacks/aks/tfvars/dev.tfvars`.

## About

[![BoltOps Badge](https://img.boltops.com/boltops/badges/boltops-badge.png)](https://www.boltops.com)

[Terraspace](https://terraspace.cloud/) and this project was built by [BoltOps](https://www.boltops.com). We also offer:

* [Paid Consulting Services](https://www.boltops.com/consulting)
* [BoltOps Pro: Infrastructure Code as a Service](https://www.boltops.com/pro)
