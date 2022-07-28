{{ with secret "gitlab/kv/consul_gossip_key" }}
{{ .Data.key}}
{{ end }}
