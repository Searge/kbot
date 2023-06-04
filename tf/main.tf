terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

variable "GOOGLE_PROJECT_ID" {
  type        = string
  default     = "venture-clouds"
  description = "GCP Project ID"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1"
  description = "GCP Region"
}

variable "GOOGLE_ZONE" {
  type        = string
  default     = "us-central1-a"
  description = "GCP Zone"
}

provider "google" {
  project = var.GOOGLE_PROJECT_ID
  region  = var.GOOGLE_REGION
  zone    = var.GOOGLE_ZONE
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "Machine type for the GKE cluster"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 2
  description = "Number of nodes in the GKE cluster"
}

resource "google_container_cluster" "demo" {
  name     = "demo-cluster"
  location = var.GOOGLE_ZONE

  remove_default_node_pool = true
  initial_node_count       = 3

}

resource "google_container_node_pool" "main" {
  name       = "main"
  project    = google_container_cluster.demo.project
  cluster    = google_container_cluster.demo.name
  location   = google_container_cluster.demo.location
  node_count = var.GKE_NUM_NODES

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
    disk_size_gb = 10
    preemptible  = true

  }
}
