path "hashistack/kv/consul_gossip_key" {
  capabilities = [ "read", "create", "update" ]
}

path "hashistack/pki_int_consul/issue/consul-home" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_consul" {
  capabilities = [ "read" ]
}

path "hashistack/pki/tidy" {
  capabilities = [ "create", "update" ]
}

path "hashistack/pki_int_consul/tidy" {
  capabilities = [ "create", "update" ]
}