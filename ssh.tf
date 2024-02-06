# Generate SSH Key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

## Write Generated SSH Key to local file
#resource "local_file" "private_key" {
#  content         = tls_private_key.ssh.private_key_pem
#  filename        = var.private_key_filename
#  file_permission = "0400"
#}

resource "aws_key_pair" "ssh" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh.public_key_openssh
   tags       = var.tags
}