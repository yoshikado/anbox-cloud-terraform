//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//

variable "channel" {
  description = "Channel for the deployed charm"
  type        = string
  default     = "latest/stable"
}

variable "constraints" {
  description = "List of constraints that need to be applied to applications. Each constraint must be of format `<constraint_name>=<constraint_value>`"
  type        = list(string)
  default     = []
}

variable "enable_ha" {
  description = "Number of lxd nodes to deploy per subcluster"
  type        = bool
  default     = false
}

variable "enable_cos" {
  description = "Enable cos integration by deploying grafana-agent charm."
  type        = bool
  default     = false
}

variable "enable_logrotated" {
  description = "Enable relation with logrotated charm for anbox cloud"
  type        = bool
  default     = true
}

variable "config_logrotated" {
  description = "Configurations for logrotated"
  type        = map(string)
  
  default = {
    "logrotate-retention" = "60"
  }
}

variable "enable_landscape_client" {
  description = "Enable relation with landscape-client charm for anbox cloud"
  type        = bool
  default     = true
}

variable "config_landscape_client" {
  description = "Configurations for landscape-client"
  type        = map(string)
  
  default = {
    "account-name" = "standalone"
    "disable-unattended-upgrades" = "true"
  }
}

variable "ssh_public_key" {
  description = "SSH key to be imported in the juju models. No key is imported by default."
  type        = string
  default     = ""
}

variable "image_stream" {
  description = "Set the model's image-stream. By default it is set to 'released'."
  type        = string
  default     = "released"
}

variable "ubuntu_base" {
  description = "Set the default ubuntu base. Default is set to 24.04"
  type        = string
  default     = "ubuntu@24.04"
}