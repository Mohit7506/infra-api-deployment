variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "imago-deployer"
}

variable "public_key_path" {
  description = "Local public key path"
  type        = string
  default     = "~/.ssh/id_rsa_imago.pub"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

