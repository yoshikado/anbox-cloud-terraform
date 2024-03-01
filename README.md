<!-- BEGIN_TF_DOCS -->
# Anbox Cloud Terraform

This is a terraform plan to deploy anbox cloud using juju and terraform.
The module uses `terraform-provider-juju` to deploy the anbox bundles to a
bootstrapped juju cluster.

This plan uses a submodule to deploy an anbox subcluster the documentation for
it can be found [here](./modules/subcluster/README.md)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_juju"></a> [juju](#requirement\_juju) | ~> 0.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_juju"></a> [juju](#provider\_juju) | 0.10.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subcluster"></a> [subcluster](#module\_subcluster) | ./modules/subcluster | n/a |

## Resources

| Name | Type |
|------|------|
| [juju_model.anbox_cloud](https://registry.terraform.io/providers/juju/juju/latest/docs/resources/model) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_name"></a> [cloud\_name](#input\_cloud\_name) | Name of the cloud to deploy the subcluster to | `string` | n/a | yes |
| <a name="input_constraints"></a> [constraints](#input\_constraints) | List of constraints that need to be applied to applications. Each constraint must be of format `<constraint_name>=<constraint_value>` | `list(string)` | `[]` | no |
| <a name="input_subclusters_per_region"></a> [subclusters\_per\_region](#input\_subclusters\_per\_region) | Number of subclusters per region in the given cloud e.g `{ ap-south-east-1 = 1 }` | `map(number)` | n/a | yes |
| <a name="input_ua_token"></a> [ua\_token](#input\_ua\_token) | Pro token used for anbox services | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_anbox_cloud_subclusters"></a> [anbox\_cloud\_subclusters](#output\_anbox\_cloud\_subclusters) | n/a |

## Usage
The module can deploy a number of anbox subclusters per juju region using the
variable `var.subclusters_per_region`. To execute the terraform plan:

> Note: You need to have juju controller bootstrapped and a juju client
> configured on your local system to be able to use the plan.

* Create a file called `anbox.tfvars` and set the values for the variables e.g

```tfvars
ua_token = "<pro_token_here>"
subclusters_per_region = {
    ap-southeast-1 = 1
}
cloud_name = "aws"
constraints = [ "arch=arm64" ]
```

* Initialise the terraform directory

```shell
terraform init
```

* Create a terraform plan using

```shell
terraform plan -out=tfplan -var-file=anbox.tfvars
```

* Apply the terraform plan using

```shell
terraform apply tfplan
```

## Contributing
### Generate Docs
This repository uses [terraform docs](https://terraform-docs.io/) to generate
the docs. To generate docs run:

```shell
./scripts/generate-docs.sh
```
<!-- END_TF_DOCS -->
