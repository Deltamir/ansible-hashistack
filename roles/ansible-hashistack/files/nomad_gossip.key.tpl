{{ with secret "hashistack/kv/nomad_gossip_key" }}
{{ .Data.key}}
{{ end }}
