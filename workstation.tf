# Network interface for the Windows workstation
resource "azurerm_network_interface" "workstation" {
  name                = "workstation-nic"
  location            = azurerm_resource_group.lab_resourcegroup.location
  resource_group_name = azurerm_resource_group.lab_resourcegroup.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = "10.0.1.10" 
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                            = "windows2016-vm"
  resource_group_name             = azurerm_resource_group.lab_resourcegroup.name
  location                        = azurerm_resource_group.lab_resourcegroup.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "P@ssw0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.workstation.id,
  ]

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}