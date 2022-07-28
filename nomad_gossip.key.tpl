{{ with secret "gitlab/kv/nomad_gossip_key" }}
{{ .Data.key}}
{{ end }}
