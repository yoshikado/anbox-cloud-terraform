//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//

variable "constraints" {
  description = "List of constraints that need to be applied to applications. Each constraint must be of format `<constraint_name>=<constraint_value>`"
  type        = list(string)
  default     = []
}

variable "anbox_channel" {
  description = "Channel to deploy anbox cloud charms from."
  type        = string

  validation {
    condition     = can(regex("\\d+\\.\\d+\\/\\w+", var.anbox_channel))
    error_message = "Channel should be of the format `\\d+.\\d+/\\w+`"
  }
}

variable "subclusters" {
  type = list(object({
    name           = string
    lxd_node_count = number
    registry = optional(object({
      mode = optional(string)
    }))
  }))
  default     = []
  description = "List of subclusters to deploy."
  validation {
    condition     = length(var.subclusters) > 0
    error_message = "Minimum 1 subcluster is required."
  }
  validation {
    condition     = alltrue([for c in var.subclusters : c.registry == null ? true : length(c.registry.mode) > 0 ? true : false])
    error_message = "Registry mode must be set if registry is enabled"
  }
}

variable "enable_cos" {
  description = "Enable cos integration by deploying grafana-agent charm."
  type        = bool
  default     = false
}

variable "enable_ha" {
  description = "Enable HA mode for anbox cloud"
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

variable "deploy_registry" {
  description = "Deploy the Anbox Application Registry"
  type        = bool
  default     = false
}

variable "ssh_key_path" {
  description = "Path to the SSH key to be imported in the juju models. No key is imported by default."
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

variable "model_config_anbox_controller" {
  description = "Model configs for anbox-controller"
  type        = map(string)
  
  default = {
    logging-config              = "<root>=INFO"
    update-status-hook-interval = "5m"
  }
}

variable "lxd_constraints" {
  description = "List of constraints that need to be applied to LXD. Each constraint must be of format `<constraint_name>=<constraint_value>`"
  type        = list(string)
  default     = ["arch=amd64", "cpu-cores=8", "mem=16G", "root-disk=50G"]
}
