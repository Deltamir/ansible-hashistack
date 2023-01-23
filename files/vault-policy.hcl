path "hashistack/pki_int_vault/issue/vault-home" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_vault" {
  capabilities = [ "read" ]
}

path "hashistack/pki/tidy" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_vault/tidy" {
  capabilities = [ "create", "update" ]
}