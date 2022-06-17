terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.47.0"
    }

    null = {
      version = "~> 3.1.1"
    }
  }
}