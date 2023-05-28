variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive = true
}

variable "domain" {
  type        = string
  description = "Domain name"
}