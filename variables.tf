variable "kube_version" {
  type    = string
  default = "1.26.4"
}

variable "rancher_version" {
  type    = string
  default = "2"
}

variable "project_name" {
  type = string
}

variable "user_name" {
  type = string
}

variable "master_flavor" {
  type    = string
  default = "m1.medium"
}

variable "node_flavor" {
  type    = string
  default = "m1.large"
}

variable "image_name" {
  type    = string
  default = "Fedora-Core-38"
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 3
}

variable "name" {
  type    = string
  default = null
}

variable "external_network_name" {
  type    = string
  default = "external"
}

variable "kubernetes_network_name" {
  type    = string
  default = "kubernetes"
}

variable "auto_healing_enabled" {
  type    = bool
  default = true
}

variable "auto_scaling_enabled" {
  type    = bool
  default = true
}

variable "prometheus_monitoring" {
  type    = bool
  default = false
}

variable "kube_dashboard_enabled" {
  type    = bool
  default = false
}

variable "master_lb_enabled" {
  type    = bool
  default = false
}

variable "cinder_csi_enabled" {
  type    = bool
  default = true
}

variable "nfs_enabled" {
  type    = bool
  default = false
}

variable "nfs_server" {
  type    = string
  default = ""
}

variable "nfs_mount_point" {
  type    = string
  default = ""
}
