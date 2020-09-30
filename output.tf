output "instance_public_ip" {
    value = azurerm_public_ip.instance.fqdn
}