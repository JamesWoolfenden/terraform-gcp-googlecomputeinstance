resource "local_file" "public" {
  content  = "${tls_private_key.ssh.public_key_openssh}"
  filename = "id_rsa.pub"
}
