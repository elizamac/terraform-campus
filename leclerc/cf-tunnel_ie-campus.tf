variable "cf_api_token" {
  type = string
  sensitive = true
  default = ""
}
provider "cloudflare" {
  api_token = var.cf_api_token
}

data "cloudflare_tunnel" "ie-campus" {
  account_id = "926a3519c18f07a19d06041db5732dd3"
  name = "IE Campus"
}