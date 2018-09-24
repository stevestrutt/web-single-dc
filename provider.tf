variable "iaas_username" {}
variable "ibmcloud_iaas_api_key" {}

provider "ibm" {
  softlayer_username = "${var.iaas_username}"
  softlayer_api_key  = "${var.ibmcloud_iaas_api_key}"
}
