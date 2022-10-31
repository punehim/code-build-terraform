#================================

variable "description" {
  default = "This is script to create large files from small files"
  
}
variable "max-retries" {
  default = "1"
}

variable "timeout" {
  default = "1440"
}

variable "number-of-workers" {
  default = "5"
}

variable "worker-type" {
  default = "G.2X"
}

variable "max_concurrent_runs" {
  default = 2
}

variable "job-language" {
  default = "python"
}

variable "bucket-name" {
  default = "terraform-glue-job-bucket"
}

variable "job-name" {
  default = "compress-small-files-large-files"
}
variable "file-name" {
  default = "glue-compress.py"
}

variable "aws_region" {
  type = string
  description = "The region in which the resources will be created"
  default = "The aws development account aws_region"
}

variable "access_key" {
  type = string
  description = "The aws development account access key"
}

variable "secret_key" {
  type = string
  description = "The aws development account secret key"
}

variable "token" {
  type        = string
  description = "The aws development account secret key"
}
