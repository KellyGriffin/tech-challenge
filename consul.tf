provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "consul" {
  source = "github.com/hashicorp/consul/terraform/aws"
  key_name = "awspersonal"
  key_path = "/Users/chris.matteson/Downloads/awspersonal.pem"
  region   = "us-west-2"
  servers  = "3"
}
