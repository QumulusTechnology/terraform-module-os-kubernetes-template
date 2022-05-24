variable "kube_version" {
  type    = string
  default = "1.22.8"
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

