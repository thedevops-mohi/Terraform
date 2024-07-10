

data "vsphere_virtual_machine" "template" {

  name          = var.template_name // Template to be cloned e.g Centos-7
  datacenter_id = data.vsphere_datacenter.dc.id

}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name                                           // Name of the VM. e.g Mohammed-NSG-1
  folder           = data.vsphere_folder.folder.path                       // VM folder to store VMs. e.g Mohammed
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id //
  datastore_id     = data.vsphere_datastore.datastore.id                   //storage to where VM will be stored. e.g TrueNAS
  num_cpus         = data.vsphere_virtual_machine.template.num_cpus        // CPU of the VM, to be inherited from template
  memory           = var.purpose == "web" ? 4064 : 1024                    // Memory of the VM, to be inherited from template
  guest_id         = data.vsphere_virtual_machine.template.guest_id        // The guest OS, to be inherited from the template e.g CentOS 7 (64-bit)
  force_power_off  = true



  network_interface {
    network_id = data.vsphere_network.network2.id //vNIC id of the VM
  }

  network_interface {
    network_id = data.vsphere_network.network3.id //vNIC id of the VM
  }

  # dynamic "network_interface" {
  #   for_each = index(var.vnic)
  #   content {
  #     network_id = data.vsphere_network.network[network_interface.index].id
  #   }

  # }

  disk {
    label            = "disk0"
    size             = var.purpose == "web" ? 100 : 50                                //The size of the VM will be determined by the template
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned // This can be determined by the template. If thin provision is enabled VM size expands as data are written to it. 

  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.uuid //Universally unique identifier of the Template to be clone.
  }

}

