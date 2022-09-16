# Create a virtual network within the resource group
resource "azurerm_virtual_network" "internal" {
  name                = "internal-network"
  resource_group_name = azurerm_resource_group.lab_resourcegroup.name
  location            = azurerm_resource_group.lab_resourcegroup.location
  address_space       = ["10.0.0.0/16"]
}
# Subnet 10.0.1.0/24
resource "azurerm_subnet" "internal_subnet" {
  name                 = "internal-subnet"
  resource_group_name  = azurerm_resource_group.lab_resourcegroup.name
  virtual_network_name = azurerm_virtual_network.internal.name
  address_prefixes     = ["10.0.1.0/24"]
}
