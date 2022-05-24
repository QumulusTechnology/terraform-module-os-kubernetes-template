
# terraform-module-os-kubernetes-template


example usage

**[main.tf]**

    variable "project_name" {}
    variable "user_name" {}
    
    module "coe_template" {
      source = "git@github.com:QumulusTechnology/terraform-module-os-kubernetes-template.git"
    
      kube_version = "1.22.8"
    
      project_name = var.project_name
      user_name    = var.user_name
    }

    output "template_name" {
      value = module.coe_template.name
    }

    output "template_id" {
      value = module.coe_template.id
    }
