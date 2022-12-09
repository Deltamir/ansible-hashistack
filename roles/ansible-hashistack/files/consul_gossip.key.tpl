{{ with secret "hashistack/kv/consul_gossip_key" }}{{ .Data.key}}{{ end }}
