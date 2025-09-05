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
