module "subcluster" {
  source        = "./subcluster"
  ua_token      = var.ua_token
  channel       = "1.21/stable"
  external_etcd = true
  constraints   = ["arch=arm64"]
  lxd_nodes     = 2
}
