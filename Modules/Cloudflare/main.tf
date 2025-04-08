
resource "cloudflare_zone_settings_override" "example" {
  zone_id = "example-zone-id"
  settings {
    ssl = "strict"
    min_tls_version = "1.2"
  }
}
