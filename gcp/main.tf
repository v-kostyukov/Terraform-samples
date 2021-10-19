provider "google" {
  #credentials = file("gcp-credentials.json")
  project     = "gcp-project-sm"
  region      = "europe-central2"
  zone        = "europe-central2-a"
}

resource "google_compute_instance" "linux_server" {
  name = "debian-server"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
  }
}