data "cloudflare_tunnel" "ie-campus" {
  account_id = "926a3519c18f07a19d06041db5732dd3"
  name = "IE Campus"
}

resource "cloudflare_tunnel_config" "code-tunnel" {
  account_id = data.cloudflare_tunnel.ie-campus.account_id
  tunnel_id = data.cloudflare_tunnel.ie-campus.id

  config {
    ingress_rule {
      hostname = "code"
      service = "http://10.94.117.21:8200"
    }
  }
}