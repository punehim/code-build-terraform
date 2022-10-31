provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  #token = var.token
}

data "aws_s3_bucket" "selected" {
  bucket = "terraform-glue-job-bucket"
}

data "aws_iam_role" "example" {
  name = "allserviceaccess"
}

resource "aws_glue_job" "glue-job" {
  name = "${var.job-name}"
  role_arn = data.aws_iam_role.example.arn
  description = var.description
  max_retries = var.max-retries
  timeout = var.timeout
  number_of_workers = var.number-of-workers
  worker_type  = var.worker-type
  
  command {
    script_location = "https://github.com/punehim/code-build-terraform.git/${var.file-name}" 
    python_version = "3"
  }
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
  glue_version = "3.0"
}
