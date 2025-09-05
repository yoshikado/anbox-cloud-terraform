//
// Copyright 2025 Canonical Ltd.  All rights reserved.
//

variable "model_suffix" {
  type        = string
  description = "Suffix to attach for model"
}

variable "channel" {
  description = "Channel for the deployed charm"
  type        = string
  default     = "latest/stable"
}

variable "external_etcd" {
  description = "Channel for the deployed charm"
  type        = bool
  default     = false
}

variable "lxd_nodes" {
  description = "Channel for the deployed charm"
  type        = number
  default     = 1
}

variable "constraints" {
  description = "List of constraints that need to be applied to applications. Each constraint must be of format `<constraint_name>=<constraint_value>`"
  type        = list(string)
  default     = []
}

variable "lxd_constraints" {
  description = "List of constraints that need to be applied to LXD. Each constraint must be of format `<constraint_name>=<constraint_value>`"
  type        = list(string)
  default     = ["arch=amd64", "cpu-cores=8", "mem=16G", "root-disk=50G"]
}

variable "enable_ha" {
  description = "Number of lxd nodes to deploy per subcluster"
  type        = bool
  default     = false
}

variable "registry_config" {
  description = "Object to represent connection details for connecting to anbox registry"
  type = object({
    mode      = string
    offer_url = string
  })
  default = null
}

variable "enable_cos" {
  description = "Enable cos integration by deploying grafana-agent charm."
  type        = bool
  default     = false
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