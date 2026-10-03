variable "RGname" {
  type        = string
  description = "Name of the Azure Resource Group"
  default     = "Cloud-RG"
}

variable "RGlocation" {
  type        = string
  description = "Azure region where resources will be created"
  default     = "Central India"
}

variable "addspace" {
  type        = list(string)
  description = "VNet and Subnet address spaces"

  default = [
    "10.0.0.0/16",
    "10.0.1.0/24"
  ]
}

variable "storagename" {

  type = string
  default = "myaccount"

}

variable "mykeyvault" {

 type = string
 default = "rpvault"

}

variable "aksname" {

 type = string
 default = "rpaks"

}
