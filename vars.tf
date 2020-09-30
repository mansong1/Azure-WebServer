variable "location" {
    description = "The location of where resources are created"
    default     = "UK South"
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which the resources are created"
    default     = ""
    type        = string
}


variable "instance_count" {
    description = "The number of virtual machines"
    default     = 1
    type        = number
}