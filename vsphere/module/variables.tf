variable "vcenter_username" {
  type        = string
  description = "Username is your Telus txID/xID"
}

variable "vcenter_password" {
  type        = string
  sensitive   = true
  description = "Username is your LDAP password"
}

variable "vcenter_server_ip" {
  type        = string
  default     = "vcsa.mdeey.com"
  description = "IP address or FQDN of the vcenter server"
}

variable "datacenter" {
  type        = string
  default     = "Home-Lab"
  description = "The datacenter is the vcenter datacenter name"
}

variable "cluster" {
  type        = string
  default     = "ESXI"
  description = "The cluster is the name of the cluster for the vcenter"
}

variable "datastore" {
  type        = string
  default     = "eve-ng"
  description = "The datastore is the name of the storage to which VM files will be stored"
}

variable "folder" {
  type        = string
  default     = "Discovered virtual machine"
  description = "This is the VM folder where the vm will be stored in"
}

variable "template_name" {
  type        = string
  default     = "Centos-7"
  description = "Template to be cloned to create VM"
}

variable "vnic1" {
  type        = string
  default     = "Management Network"
  nullable    = true
  description = "This is the port group to be associated with the vm's vNIC"
}

variable "vnic2" {
  type        = string
  default     = "Parking"
  nullable    = true
  description = "This is the port group to be associated with the vm's vNIC"
}

variable "vm_name" {
  type        = string
  description = "This is the vm name"
}

# variable "vnic" {
#   description = ""
#   type        = list(string)
#   #default     = {}
# }

variable "purpose" {
  type    = string
  default = "web"

}




