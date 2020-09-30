output "instance_public_ip" {
    value = azurerm_public_ip.instance.fqdn
}

output "jumpbox_public_ip" {
    value = azurerm_public_ip.jumpbox.fqdn
}