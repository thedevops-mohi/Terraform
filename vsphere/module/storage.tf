data "vsphere_datastore" "datastore" {
  name          = var.datastore //datastore name e.g eve-ng
  datacenter_id = data.vsphere_datacenter.dc.id
}
