resource "juju_model" "anbox_cloud" {
  name = "anbox-cloud-test"

  cloud {
    name = "juju"
  }

  constraints = join(" ", var.constraints)

  config = {
    logging-config              = "<root>=INFO"
    update-status-hook-interval = "5m"
  }
}
