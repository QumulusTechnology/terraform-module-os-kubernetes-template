locals {

  external_network_name   = coalesce(var.external_network_name, "external-${var.user_name}")
  kubernetes_network_name = coalesce(var.kubernetes_network_name, "kubernetes-${var.user_name}")
  name                    = coalesce(var.name, "${data.openstack_identity_project_v3.current.name}-v${var.kube_version}")

}

data "openstack_identity_project_v3" "current" {
  name = var.project_name
}

data "openstack_networking_network_v2" "external" {
  name = local.external_network_name
}

data "openstack_networking_network_v2" "kubernetes" {
  name = local.kubernetes_network_name
}

data "openstack_networking_subnet_v2" "kubernetes" {
  network_id = data.openstack_networking_network_v2.kubernetes.id
}

data "openstack_compute_keypair_v2" "this" {
  name = "${var.project_name}-keypair"
}

resource "openstack_containerinfra_clustertemplate_v1" "this" {
  name                  = local.name
  cluster_distro        = "fedora-coreos"
  image                 = var.image_name
  coe                   = "kubernetes"
  flavor                = var.node_flavor
  master_flavor         = var.master_flavor
  docker_storage_driver = "overlay2"
  docker_volume_size    = 20
  volume_driver         = "cinder"
  network_driver        = "calico"
  server_type           = "vm"
  master_lb_enabled     = false
  floating_ip_enabled   = false
  keypair_id            = data.openstack_compute_keypair_v2.this.id
  external_network_id   = data.openstack_networking_network_v2.external.id
  fixed_network         = data.openstack_networking_network_v2.kubernetes.id
  fixed_subnet          = data.openstack_networking_subnet_v2.kubernetes.id


  labels = {
    kube_tag                         = "v${var.kube_version}-rancher1"
    kube_dashboard_enabled           = var.kube_dashboard_enabled
    prometheus_monitoring            = var.prometheus_monitoring
    influx_grafana_dashboard_enabled = "false"
    auto_scaling_enabled             = var.auto_scaling_enabled
    auto_healing_enabled             = var.auto_healing_enabled
    auto_healing_controller          = "magnum-auto-healer"
    ingress_controller               = "octavia"
    min_node_count                   = var.min_node_count
    max_node_count                   = var.max_node_count
  }
}
