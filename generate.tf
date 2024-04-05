provider "google" {
  credentials = file("./concrete-detection-5.json") # Replace with your Google Cloud credentials file
  project     = "concrete-detection-5"                      # Replace with your GCP project ID
  region      = "us-central1"                          # Replace with your desired region
}

resource "google_container_cluster" "crack-detection-cluster" {
  name     = "crack-detection-cluster"
  location = "us-central1-a"
  initial_node_count = 2
  deletion_protection = false
  
  # Use the default VPC and subnet settings
  network            = "default"
  subnetwork         = "default"

  # Enable the GKE Autopilot mode
  release_channel {
    channel = "REGULAR"
  }
}

resource "google_compute_disk" "concrete-gce-nfs-disk" {
  name  = "concrete-gce-nfs-disk"
  size  = 20
  type  = "pd-standard"
  zone  = "us-central1-a"
}

data "google_container_cluster" "crack-detection-cluster" {
  name     = google_container_cluster.crack-detection-cluster.name
  location = google_container_cluster.crack-detection-cluster.location
}

resource "null_resource" "configure_kubectl" {
  # This triggers the provisioner after the GKE cluster is created.
  triggers = {
    cluster_id = google_container_cluster.crack-detection-cluster.id
  }

  # Use the local-exec provisioner to run the gcloud command.
  provisioner "local-exec" {
    command     = "gcloud container clusters get-credentials ${google_container_cluster.crack-detection-cluster.name} --zone ${google_container_cluster.crack-detection-cluster.location}"
    interpreter = ["bash", "-c"]
  }
}

output "cluster_name" {
  value = google_container_cluster.crack-detection-cluster.name
}