terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.0"
    }
  }
}

provider "vsphere" {
  user                 = var.vcenter_username  //e.g administrator@vsphere.local
  password             = var.vcenter_password  // e.g LDAP password
  vsphere_server       = var.vcenter_server_ip //vcenter IP or FQDN. e.g vcsa.mdeey.com
  allow_unverified_ssl = true                  // ignore ssl verification
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter //data center name. e.g Home-Lab
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster // Cluster name e.g ESXI
  datacenter_id = data.vsphere_datacenter.dc.id
}

# data "vsphere_folder" "folder" {
#   path = var.folder // Folder to store VM. e.g terraform
#   #type = "vm"
#   #datacenter_id = data.vsphere_datacenter.dc.id

# }

data "vsphere_folder" "folder" {
  path = var.folder
  #type          = "vm"
  #datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_resource_pool" "rp" {
  name                    = "test"
  parent_resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  #datacenter_id = data.vsphere_datacenter.dc.id
}
