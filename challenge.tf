provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

#module "consul" {
#  source = "git::https://github.com/chrismatteson/consul//terraform/aws?ref=terraform_enterprise"
#  key_name = "${var.key_name}"
#  private_key = "${var.private_key}"
#  region   = "us-west-2"
#  servers  = "3"
#}

module "nomad" {
  source = "git::https://github.com/chrismatteson/nomad//terraform/aws/modules/hashistack?ref=challenge"
  key_name = "${var.key_name}"
  ami = "${var.ami}"
  server_count = 3
  instance_type = "t2.micro"
  client_count = 3
  cluster_tag_value = "hashicorp"
  region = "${var.region}"
}
