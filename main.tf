terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "pocketbase" {
  image     = "ubuntu-20-04-x64"
  name      = "pocketbase"
  region    = "ams3"
  size      = "s-1vcpu-1gb"
  user_data = file("cloud-config.yml")
  tags      = ["pocketbase"]
}


data "digitalocean_domain" "pocketbase" {
  name = var.domain
}

# wait for the droplet to be created
resource "null_resource" "wait-for-droplet" {
  depends_on = [digitalocean_droplet.pocketbase]
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "digitalocean_reserved_ip" "pocketbase" {
  droplet_id = digitalocean_droplet.pocketbase.id
  region     = "ams3"
  depends_on = [null_resource.wait-for-droplet]
}

resource "digitalocean_record" "pocketbase" {
  domain     = data.digitalocean_domain.pocketbase.name
  type       = "A"
  name       = "pb"
  value      = digitalocean_reserved_ip.pocketbase.ip_address
  depends_on = [digitalocean_reserved_ip.pocketbase]
}
