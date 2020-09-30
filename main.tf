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

resource "azurerm_lb" "main" {
    name                = "${var.resource_group_name}-lb"
    location            = var.location
    resource_group_name = azurerm_resource_group.main.name

    frontend_ip_configuration {
        name                 = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.main.id
    }

    tags = {
        environment = "udacity"
    }
}

resource "azurerm_lb_backend_address_pool" "main" {
    name                = "BackEndAddressPool"
    resource_group_name = azurerm_resource_group.main.name
    loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
    name                = "ssh-running-probe"
    resource_group_name = azurerm_resource_group.main.name
    loadbalancer_id     = azurerm_lb.main.id
    port                = var.application_port
}

resource "azurerm_lb_rule" "main" {
    resource_group_name            = azurerm_resource_group.main.name
    loadbalancer_id                = azurerm_lb.main.id
    name                           = "http"
    protocol                       = "Tcp"
    frontend_port                  = var.application_port
    backend_port                   = var.application_port
    backend_address_pool_id        = azurerm_lb_backend_address_pool.main.id
    frontend_ip_configuration_name = "PublicIPAddress"
    probe_id                       = azurerm_lb_probe.main.id
}

data "azurerm_resource_group" "image" {
    name = "udacityImageGroup"
}

data "azurerm_image" "image" {
    name                = "udacityPackerImage"
    resource_group_name = data.azurerm_resource_group.image.name
}

resource "azurerm_virtual_machine_scale_set" "main" {
    name                = "${var.resource_group_name}-vmscaleset"
    location            = var.location
    resource_group_name = azurerm_resource_group.main.name
    upgrade_policy_mode = "Manual"

    sku {
        name     = "Standard_D2s_v3"
        tier     = "Standard"
        capacity = 2
    }

    storage_profile_image_reference {
        id=data.azurerm_image.image.id
    }

    storage_profile_os_disk {
        name              = ""
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_profile_data_disk {
        lun          = 0
        caching        = "ReadWrite"
        create_option  = "Empty"
        disk_size_gb   = 10
    }

    os_profile {
        computer_name_prefix = "udacity"
        admin_username       = "udacityuser"
        admin_password       = "Passwword1234"
    }

    os_profile_linux_config {
        disable_password_authentication = true

        ssh_keys {
            path     = "/home/azureuser/.ssh/authorized_keys"
            key_data = file("~/.ssh/id_rsa.pub")
        }
    }

    network_profile {
        name    = "terraformnetworkprofile"
        primary = true

        ip_configuration {
            primary                                = true
            name                                   = "IPConfiguration"
            subnet_id                              = azurerm_subnet.main.id
            load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.main.id]
        }
    }
    
    tags = {
        environment = "udacity"
    }
}