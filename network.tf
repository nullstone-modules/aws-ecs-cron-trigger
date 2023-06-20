data "ns_app_connection" "network" {
  name     = "network"
  contract = "network/aws/vpc"
  via      = "${data.ns_app_connection.cluster_namespace.name}/${data.ns_app_connection.cluster.name}"
}

locals {
  private_subnet_ids = data.ns_app_connection.network.outputs.private_subnet_ids
}
