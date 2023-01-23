path "hashistack/kv/nomad_gossip_key" {
  capabilities = [ "read", "create", "update" ]
}

path "hashistack/pki_int_nomad/issue/nomad-home" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_nomad" {
  capabilities = [ "read" ]
}

path "hashistack/pki/tidy" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_nomad/tidy" {
  capabilities = [ "create", "update" ]
}