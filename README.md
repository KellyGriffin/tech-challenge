# HashiCorp SE Tech Challenge

This repository is the primary location for code related to
my submission for the HashiCorp SE Tech Challenge. There are
two primary stacks which this is intended to setup:

1) Packer built Hashistack forked from the Nomad module that
includes Nomad, Vault, and Consul. This stack then uses
terraform to instruct the Nomad to build apply another Packer
built image (this time a docker file) which hosts a copy of
the terraform.io website.

2) The second stack utilizes the consul terraform module to stand
up consul. It's currently commented out and I should probably
delete this.

Both of these stacks should work with both Terraform Open Source
and Terraform Enterprise. The Consul module for the second
stack was modified to allow the private key to be stored as an
Environment variable instea of Terraform Enterprise, such that
all management can occur through that platform.
