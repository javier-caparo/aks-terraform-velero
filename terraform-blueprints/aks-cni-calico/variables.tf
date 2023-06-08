variable "location" {
  description = "The resource group location"
  default     = "East US 2"
}

variable "vnet_resource_group_name" {
  description = "The resource group name to be created"
  default     = "aks-calico"
}

variable "admin_username" {
  description = "Admin username"
  default     = "azureuser"
}

variable "admin_ssh_key" {
  description = "Admin SSH public key"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCcliL7yTCwod5GQIz8+zUareXHngz8Bt/HsdiawS4caW+Rm+c4vp53vQht3q3HHKjqiTUNgMJG6iRaRsa02Lw3cYZCeF33NgIsrZGMA2AIBIuVMderqVay5wmTaGJDYHQqNUm0EvtOXVf7TkEpkDimwpDOjyw6sCaAEIZxf1HiuVCfc/eWD0y2CLpavBZHVNp/JOjhl5oUbLjP54vtRk8/6bzrnbOT30ikqGtTYe7Fv8AFfZIw84dhOchEroZZa+PgUysfVknUJOVNgCPL1MQl1+u4owrPq6bhT549bSHS5bs1YeCJxz9oldvvL+4mLLfPqouBU/vvnj+9BJ8G/Gwd"
}

variable "aks_vnet_name" {
  description = "VNET name"
  default     = "aks-vnet"
}

variable "cluster_name" {
  description = "AKS cluster name"
  default     = "aks-azure-cni-with-calico"
}

variable "kube_version_prefix" {
  description = "AKS Kubernetes version prefix. Formatted '[Major].[Minor]' like '1.18'. Patch version part (as in '[Major].[Minor].[Patch]') will be set to latest automatically."
  default     = "1.25"
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  default     = 2
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_B4ms"
}

variable "network_dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "10.9.0.10"
}

variable "network_service_cidr" {
  description = "CNI service cidr"
  default     = "10.9.0.0/16"
}

variable "network_docker_bridge_cidr" {
  description = "Docker bridge cidr"
  default     = "172.17.0.1/16"
}

variable "sa_name" {
  description = "Storage accoutn name for velero"
}