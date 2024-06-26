locals {
  name = coalesce(var.name, "${data.openstack_identity_project_v3.current.name}-v${var.kube_version}")
}

data "openstack_identity_project_v3" "current" {
  name = var.project_name
}


data "openstack_networking_network_v2" "external" {
  name      = var.external_network_name
  tenant_id = var.external_network_name == "public" ? null : data.openstack_identity_project_v3.current.id
}

data "openstack_networking_network_v2" "kubernetes" {
  name      = var.kubernetes_network_name
  tenant_id = data.openstack_identity_project_v3.current.id
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
  docker_volume_size    = var.docker_volume_size
  volume_driver         = "cinder"
  network_driver        = "calico"
  server_type           = "vm"
  master_lb_enabled     = var.master_lb_enabled
  floating_ip_enabled   = false
  keypair_id            = data.openstack_compute_keypair_v2.this.id
  external_network_id   = data.openstack_networking_network_v2.external.id
  fixed_network         = data.openstack_networking_network_v2.kubernetes.id
  fixed_subnet          = data.openstack_networking_subnet_v2.kubernetes.id


  labels = {
    kube_tag                                = "v${var.kube_version}-rancher${var.rancher_version}"
    kube_dashboard_enabled                  = var.kube_dashboard_enabled
    prometheus_monitoring                   = var.prometheus_monitoring
    influx_grafana_dashboard_enabled        = "false"
    auto_scaling_enabled                    = var.auto_scaling_enabled
    auto_healing_enabled                    = var.auto_healing_enabled
    auto_healing_controller                 = "magnum-auto-healer"
    ingress_controller                      = "octavia"
    min_node_count                          = var.min_node_count
    max_node_count                          = var.max_node_count
    vault_ssh_enabled                       = "true"
    vault_url                               = "https://vault.qumulus.io"
    vault_mount_point                       = "openstack/ssh/${data.openstack_identity_project_v3.current.id}"
    vault_allowed_roles                     = "*"
    cinder_csi_enabled                      = var.cinder_csi_enabled
    nfs_subdir_external_provisioner_enabled = var.nfs_enabled
    nfs_server                              = var.nfs_server
    nfs_mount_point                         = var.nfs_mount_point
    dockerhub_repo_path                     = "${var.image_repo_mirror}/dockerhub-proxy"
    quay_repo_path                          = "${var.image_repo_mirror}/quay-proxy"
    gcr_repo_path                           = "${var.image_repo_mirror}/gcr-proxy"
    k8s_repo_path                           = "${var.image_repo_mirror}/k8s-proxy"
    hyperkube_prefix                        = "${var.image_repo_mirror}/dockerhub-proxy/rancher/"
  }

  lifecycle {
    ignore_changes = [
      docker_volume_size,
    ]
  }
}
