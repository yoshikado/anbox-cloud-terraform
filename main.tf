locals {
  model_names = flatten(
    [for region, clusters in var.subclusters_per_region : [for cluster_name in clusters : "${region}.${cluster_name}"]]
  )
}
module "subcluster" {
  for_each               = juju_model.anbox_cloud
  source                 = "./modules/subcluster"
  model_name             = juju_model.anbox_cloud[each.key].name
  ua_token               = var.ua_token
  channel                = "1.21/stable"
  external_etcd          = true
  constraints            = var.constraints
  lxd_nodes              = var.lxd_nodes_per_subcluster
  deploy_streaming_stack = true
  deploy_dashboard       = true
}

resource "juju_model" "anbox_cloud" {
  for_each = toset(local.model_names)
  name     = "anbox-cloud-${replace(each.value, ".", "-")}"

  cloud {
    name   = var.cloud_name
    region = split(".", each.value)[0]
  }

  constraints = join(" ", var.constraints)

  config = {
    logging-config              = "<root>=INFO"
    update-status-hook-interval = "5m"
  }
}
