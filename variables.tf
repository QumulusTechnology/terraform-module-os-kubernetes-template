variable "kube_version" {
  type    = string
  default = "1.23.9"
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
  default = "fedora-coreos-latest"
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

