output "ip_address" {
  value = digitalocean_droplet. pocketbase.ipv4_address
  description = "The public IP address of your Droplet application."
}

# the reserverd IP address
output "reserved_ip_address" {
  value = digitalocean_reserved_ip. pocketbase.ip_address
  description = "The reserved IP address of your Droplet application."
}

# the domain name
output "domain_name" {
  value = data.digitalocean_domain. pocketbase.name
  description = "The domain name of your Droplet application."
}