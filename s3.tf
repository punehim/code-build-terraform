provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
 # token = "${var.aws_session_token}"
  region     = "${var.region}"
}

resource "aws_s3_bucket" "file_upload_bucket" {
  bucket = "pappua-ginni"
  acl    = "private"
}
