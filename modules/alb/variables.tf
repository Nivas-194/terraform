variable "public_subnets" {
  type = list(string)
}

variable "alb_sg" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "instance_ids" {
  type = list(string)
}