//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//

resource "juju_application" "lxd" {
  name = "lxd"

  model       = juju_model.subcluster.name
  constraints = join(" ", concat(var.lxd_constraints))

  charm {
    name    = "ams-lxd"
    channel = var.channel
    base    = local.base
  }

  machines = juju_machine.lxd_node[*].machine_id
  // FIXME: Currently the provider has some issues with reconciling state using
  // the response from the JUJU APIs. This is done just to ignore the changes in
  // string values returned.
  #lifecycle {
  #  ignore_changes = [constraints]
  #}
}

resource "juju_application" "ams_node_controller" {
  name = "ams-node-controller"

  model = juju_model.subcluster.name

  charm {
    name    = "ams-node-controller"
    channel = var.channel
    base    = local.base
  }

  config = {
    port            = "10000-11000"
    snap_risk_level = local.risk
  }
}

resource "juju_integration" "lxd_cos" {
  count = var.enable_cos ? 1 : 0
  model = juju_model.subcluster.name

  application {
    name     = juju_application.lxd.name
    endpoint = "juju-info"
  }

  application {
    name     = one(juju_application.cos_agent[*].name)
    endpoint = "juju-info"
  }
}

resource "juju_integration" "lxd_logrotated" {
  count = var.enable_logrotated ? 1 : 0
  model = juju_model.subcluster.name

  application {
    name     = juju_application.lxd.name
    endpoint = "juju-info"
  }

  application {
    name     = one(juju_application.logrotated[*].name)
    endpoint = "juju-info"
  }
}

resource "juju_integration" "lxd_landscape_client" {
  count = var.enable_logrotated ? 1 : 0
  model = juju_model.subcluster.name

  application {
    name     = juju_application.lxd.name
    endpoint = "juju-info"
  }

  application {
    name     = one(juju_application.landscape_client[*].name)
    endpoint = "container"
  }
}

resource "juju_integration" "ip_table_rules" {
  model = juju_model.subcluster.name

  application {
    name     = juju_application.ams_node_controller.name
    endpoint = "lxd"
  }

  application {
    name     = juju_application.lxd.name
    endpoint = "api"
  }
}

resource "juju_integration" "ams_lxd" {
  model = juju_model.subcluster.name

  application {
    name     = juju_application.ams.name
    endpoint = "lxd"
  }

  application {
    name     = juju_application.lxd.name
    endpoint = "api"
  }
}

resource "juju_machine" "lxd_node" {
  model       = juju_model.subcluster.name
  count       = var.lxd_nodes
  base        = local.base
  name        = "lxd-${count.index}"
  constraints = join(" ", var.lxd_constraints)
}
