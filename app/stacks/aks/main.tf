locals {
  resource_group_name = "aks-test-resources"
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = "<%= AzureInfo.location %>"
}

module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = "aks-test-network"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = "10.11.0.0/16"
  subnet_prefixes     = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  depends_on = [azurerm_resource_group.this]
}

resource "random_pet" "this" {
  length = 2
}

module "aks" {
  source              = "../../modules/aks"
  resource_group_name = local.resource_group_name
  prefix              = random_pet.this.id
  vnet_subnet_id      = module.network.vnet_subnets[0]
  os_disk_size_gb     = 50

  depends_on = [azurerm_resource_group.this]
}
