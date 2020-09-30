resource "azurerm_resource_group" "main" {
    name     = var.resource_group_name
    location = var.location

    tags = {
        environment = "udacity"
    }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = "udacity"
  }
}

resource "azurerm_subnet" "main" {
  name                 = "${var.resource_group_name}-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "main" {
  name                         = "${var.resource_group_name}-public-ip"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.main.name
  allocation_method            = "Static"
  domain_name_label            = azurerm_resource_group.main.name

  tags = {
    environment = "udacity"
  }
}