output "applications" {
  value       = compact([juju_application.ams.id, one(juju_application.etcd[*].id), one(juju_application.ca[*].id), juju_application.lxd.id, juju_application.ams_node_controller.id])
  description = "List of applications deployed"
}
