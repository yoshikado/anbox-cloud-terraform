# Anbox Cloud Terraform

This is a terraform plan to deploy anbox cloud using juju and terraform.
The module uses `terraform-provider-juju` to deploy the anbox bundles to a
bootstrapped juju cluster.

This plan uses a submodule to deploy an anbox subcluster the documentation for
it can be found [here](./modules/subcluster/README.md)

