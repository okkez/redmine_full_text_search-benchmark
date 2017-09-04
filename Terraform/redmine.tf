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
      image = "debian-cloud/debian-9"
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
      image = "debian-cloud/debian-9"
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
      image = "debian-cloud/debian-9"
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
      image = "debian-cloud/debian-9"
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

resource "google_compute_instance" "fluentd" {
  name = "fluentd"
  machine_type = "n1-standard-2"
  zone = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
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

output "ip" {
  value = {
    "${google_compute_instance.redmine-mariadb.name}" = [
      "${google_compute_instance.redmine-mariadb.network_interface.0.access_config.0.assigned_nat_ip}",
      "${google_compute_instance.redmine-mariadb.network_interface.0.address}",
    ],
    "${google_compute_instance.redmine-mroonga.name}" = [
      "${google_compute_instance.redmine-mroonga.network_interface.0.access_config.0.assigned_nat_ip}",
      "${google_compute_instance.redmine-mroonga.network_interface.0.address}",
    ],
    "${google_compute_instance.redmine-postgresql.name}" = [
      "${google_compute_instance.redmine-postgresql.network_interface.0.access_config.0.assigned_nat_ip}",
      "${google_compute_instance.redmine-postgresql.network_interface.0.address}",
    ],
    "${google_compute_instance.redmine-pgroonga.name}" = [
      "${google_compute_instance.redmine-pgroonga.network_interface.0.access_config.0.assigned_nat_ip}",
      "${google_compute_instance.redmine-pgroonga.network_interface.0.address}",
    ],
    "${google_compute_instance.fluentd.name}" = [
      "${google_compute_instance.fluentd.network_interface.0.access_config.0.assigned_nat_ip}",
      "${google_compute_instance.fluentd.network_interface.0.address}",
    ]
  }
}
