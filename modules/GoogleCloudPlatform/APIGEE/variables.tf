variable "google-project-service" {
  description = "Google project service definition."
  type = map(object({
    project = string
    service = string
  }))
}

variable "google-compute-network" {
  type = map(object({
    project  = string
    name     = string
  }))
}

variable "google-apigee-organization" {
  description = "APIGEE project definition."
  type = map(object({
    project_id         = string
    analytics_region   = string
    authorized_network = string

  }))
}

variable "google-apigee-environment" {
  type = map(object({
    org_id = string
    name = string
  }))
}

variable "google-apigee-instance" {
  type = map(object({
    name = string
    org_id = string
    location = string

  }))
}

variable "google-apigee-environment-attachment" {
  type = map(object({
    environment = string
    instance_id = string
  }))
}