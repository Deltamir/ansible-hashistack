path "secrets/kv/*" {
  capabilities = [ "read", "create", "update" ]
}

path "secrets/transit/autounseal" {
  capabilities = [ "create", "update" ]
}

