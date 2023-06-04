resource "google_container_cluster" "demo" {
  name     = "demo-cluster"
  location = var.GOOGLE_ZONE

  remove_default_node_pool = true
  initial_node_count       = var.INIT_NODES

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
