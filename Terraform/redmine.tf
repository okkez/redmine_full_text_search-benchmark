provider "google" {
  credentials = "${file("Redmine-benchmark-fcecdb50bd04.json")}"
  project = "redmine-benchmark"
  region = "asia-norhteast1"
}

resource "google_compute_instance" "redmine-mariadb" {
  name = "redmine-mariadb"
  machine_type = "n1-standard-2"
  zone = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
      type = "pd-standard"
      size = 10
    }
  }

  network_interface = {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = false
  }
}

resource "google_compute_instance" "redmine-mroonga" {
  name = "redmine-mroonga"
  machine_type = "n1-standard-2"
  zone = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
      type = "pd-standard"
      size = 10
    }
  }

  network_interface = {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = false
  }
}

resource "google_compute_instance" "redmine-postgresql" {
  name = "redmine-postgresql"
  machine_type = "n1-standard-2"
  zone = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
      type = "pd-standard"
      size = 10
    }
  }

  network_interface = {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = false
  }
}

resource "google_compute_instance" "redmine-pgroonga" {
  name = "redmine-pgroonga"
  machine_type = "n1-standard-2"
  zone = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
      type = "pd-standard"
      size = 10
    }
  }

  network_interface = {
    network = "default"
    access_config {
    }
  }

  scheduling {
    preemptible = false
  }
}
