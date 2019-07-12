resource "local_file" "private" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "id_rsa"
}
