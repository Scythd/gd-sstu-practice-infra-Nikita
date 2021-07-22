variable "image_id" {
  type    = string
  default = "ami-083f9da9062568d5a"
}

variable "subnet" {
  type = string
}

variable "instance_sg" {
  type = string
}

variable "vpc" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet" {
  type = string
}


variable "key_name" {
  type = string
}