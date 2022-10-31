provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}


resource "aws_iam_role" "glue" {
  name = "AWSGlueServiceRoleDefault"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "glue_service" {
    role = "${aws_iam_role.glue.id}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

## If you don't already have a policy,
resource "aws_iam_role_policy" "my_s3_policy" {
  name = "my_s3_policy"
  role = "${aws_iam_role.glue.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${var.bucket-name}",
        "arn:aws:s3:::${var.bucket-name}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_glue_job" "glue-job" {
  name = "${var.job-name}"
  role_arn = "${aws_iam_role.glue.arn}"
  description = var.description
  max_retries = var.max-retries
  timeout = var.timeout
  number_of_workers = var.number-of-workers
  worker_type  = var.worker-type
  
  command {
    script_location = "s3://${var.bucket-name}/Scripts/${var.file-name}" 
    python_version = "3"
  }
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
  glue_version = "3.0"
}
