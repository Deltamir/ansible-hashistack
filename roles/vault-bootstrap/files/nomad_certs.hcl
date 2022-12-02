tls {
  rpc  = true

  ca_file   = "/opt/nomad/agent-certs/server_ca.crt"
  cert_file = "/opt/nomad/agent-certs/server_agent.crt"
  key_file  = "/opt/nomad/agent-certs/server_agent.key"

  verify_server_hostname = false
  verify_https_client = false
  rpc_upgrade_mode       = false
}
