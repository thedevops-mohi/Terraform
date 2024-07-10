
provider "vault" {

  address = "http://192.168.0.25:8200"

}

data "vault_generic_secret" "username" {

  path = "vsphere/vsphere_terraform/"

}

data "vault_generic_secret" "password" {

  path = "vsphere/vsphere_terraform/"

}


module "File_Server" {
  source = "./module"

  vcenter_username  = data.vault_generic_secret.username.data["username"] // Username is your tXID/xID 
  vcenter_password  = data.vault_generic_secret.password.data["password"] // Your LDAP password
  vcenter_server_ip = "vcsa.mdeey.com"                                    // vCenter IP or FQDN. e.g vcsa.mdeey.com
  datacenter        = "HOME-LAB"                                          // Datacenter e.g Home-Lab
  cluster           = "LAB-CLUSTER"                                       // Cluster e.g ESXI
  datastore         = "Lab-Datastore"                                     //Datastore where VM files will be stored
  folder            = "terraform"                                         //VM folder where VM will be stored. e.g Mohammed
  template_name     = "centos7_template"                                  //Template to be cloned. e.g Centos-7
  vm_name           = "My-Centos"                                         // VM name. e.g Mohammed-NSG-1
  vnic1             = "Management Network"                                //Port Group to be attached to VM.
  purpose           = "file"
  #vnic2             = "1132 - Yahaya VLAN"          //Port Group to be attached to VM.
  #vnic = ["Management Network", "1132 - Yahaya VLAN"] # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation

}

module "Web_Server" {
  source = "./module"

  vcenter_username  = data.vault_generic_secret.username.data["username"] // Username is your tXID/xID 
  vcenter_password  = data.vault_generic_secret.password.data["password"]
  vcenter_server_ip = "vcsa.mdeey.com"     // vCenter IP or FQDN. e.g vcsa.mdeey.com
  datacenter        = "HOME-LAB"           // Datacenter e.g Home-Lab
  cluster           = "LAB-CLUSTER"        // Cluster e.g ESXI
  datastore         = "Lab-Datastore"      //Datastore where VM files will be stored
  folder            = "terraform"          //VM folder where VM will be stored. e.g Mohammed
  template_name     = "ubuntu_template"    //Template to be cloned. e.g Centos-7
  vm_name           = "My-Ubuntu"          // VM name. e.g Mohammed-NSG-1
  vnic1             = "Management Network" //Port Group to be attached to VM.
  vnic2             = "Parking"            //Port Group to be attached to VM.
  purpose           = "web"
  #vnic = ["Management Network", "1132 - Yahaya VLAN"] # To use DHCP create Empty list ["",""]; You can also use a CIDR annotation

}

