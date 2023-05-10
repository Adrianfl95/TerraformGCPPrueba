provider "google" {
  credentials = file("/home/adrian/Downloads/keys/serviceaccgcp-spring-petclinic-angular-key.json")
  project = "398065119144"
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

resource "google_compute_instance" "default" {
	name = "virtual-machine-from-terraform"
	machine_type = "e2-small"
	zone = "europe-west1-c"

	boot_disk {
		initialize_params {
			image = "debian-cloud/debian-11"
		}
	}

	network_interface {
		network = "terraform-network"
		access_config {

		}
	}
		metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y"

		tags = ["http-server"]
}

resource "google_compute_firewall" "http-server" {
	name = "default-allow-http-terraform"
	network = "terraform-network"

	allow {
		protocol = "tcp"
		ports = ["22"]
	}

	source_ranges = ["0.0.0.0/0"]
	target_tags = ["http-server"]
}

output "ip" {
	value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}
	

