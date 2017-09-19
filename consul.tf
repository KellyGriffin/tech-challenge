provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "consul" {
  source = "github.com/chrismatteson/consul/terraform/aws?ref=terraform_enterprise"
  key_name = "${var.key_name}"
  private_key = "${var.private_key}"
  region   = "us-west-2"
  servers  = "3"
}
