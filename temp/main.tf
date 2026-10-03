resource "azurerm_resource_group" "Azure_Rg" {
  name     = var.RGname
  location = var.RGlocation
}

resource "azurerm_virtual_network" "Azure_Vnet" {
  name                = "cloudvnet"
  location            = azurerm_resource_group.Azure_Rg.location
  resource_group_name = azurerm_resource_group.Azure_Rg.name
  address_space       = [var.addspace[0]]
}

resource "azurerm_subnet" "Azure_Subnet" {
  name                 = "cloudsubnet1"
  resource_group_name  = azurerm_resource_group.Azure_Rg.name
  virtual_network_name = azurerm_virtual_network.Azure_Vnet.name
  address_prefixes     = [var.addspace[1]]
}

resource "azurerm_network_security_group" "Azure_NSG" {
  name                = "NSG1"
  location            = azurerm_resource_group.Azure_Rg.location
  resource_group_name = azurerm_resource_group.Azure_Rg.name
}

resource "azurerm_subnet_network_security_group_association" "Azure_NSGAssoc" {
  subnet_id                 = azurerm_subnet.Azure_Subnet.id
  network_security_group_id = azurerm_network_security_group.Azure_NSG.id
}

resource "azurerm_network_interface" "Azure_NIC" {
  name                = "nic1"
  location            = azurerm_resource_group.Azure_Rg.location
  resource_group_name = azurerm_resource_group.Azure_Rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Azure_Subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.Azure_NIC.id
  network_security_group_id = azurerm_network_security_group.Azure_NSG.id
}

resource "azurerm_linux_virtual_machine" "Azure_VM" {
  name                = "CloudLVM"
  resource_group_name = azurerm_resource_group.Azure_Rg.name
  location            = azurerm_resource_group.Azure_Rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "azureuser"

  admin_ssh_key {
    username   = "azureuser"
    public_key =  file("/home/rohi/.ssh/id_rsa.pub")
  }

  network_interface_ids = [
    azurerm_network_interface.Azure_NIC.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
