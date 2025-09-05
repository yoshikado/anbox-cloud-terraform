//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//

terraform {
  required_providers {
    juju = {
      source  = "juju/juju"
    }
  }
  required_version = "~> 1.6"
}

provider "juju" {}
