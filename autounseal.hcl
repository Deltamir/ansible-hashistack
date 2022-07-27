path "transit/encrypt/autounseal" {
   capabilities = [ "update" ]
}

path "transit/decrypt/autounseal" {
   capabilities = [ "update" ]
}

path "/auth/token/renew-self" {
   capabilities = [ "update", "create" ]
}
