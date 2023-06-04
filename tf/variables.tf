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
