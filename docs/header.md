# Anbox Cloud Terraform

> [!WARNING]
> This terraform plan is a work in progress and makes use of [terraform-provider-juju](https://github.com/juju/terraform-provider-juju)
> which is in active development too. Please expect breaking changes (if required) in the future for the plan and the module.


This is a terraform plan to deploy anbox cloud using juju and terraform.
The module uses `terraform-provider-juju` to deploy the anbox bundles to a
bootstrapped juju cluster.

This plan uses a submodule to deploy an anbox subcluster the documentation for
it can be found [here](./modules/subcluster/README.md)


