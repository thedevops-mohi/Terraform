# data "vsphere_network" "network" {
#   count = length(var.vnic)
#   #name          = index(var.vnic)[count.index]
#   name = count.index
#   datacenter_id = data.vsphere_datacenter.dc.id
# }

data "vsphere_network" "network2" {
  name = var.vnic1
  #name = "Management Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_network" "network3" {
  name = var.vnic2
  #name = "Internet-trunk"
  datacenter_id = data.vsphere_datacenter.dc.id
}


