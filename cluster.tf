data "ns_app_connection" "cluster_namespace" {
  name     = "cluster-namespace"
  contract = "cluster-namespace/aws/ecs:*"
}

data "ns_app_connection" "cluster" {
  name     = "cluster"
  contract = "cluster/aws/ecs:*"
  via      = data.ns_app_connection.cluster_namespace.name
}

locals {
  cluster_arn = data.ns_app_connection.cluster.cluster_arn
}
