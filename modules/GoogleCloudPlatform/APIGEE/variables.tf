variable "google-project-service" {
  description = "Google project service definition."
  type = map(object({
    project = string
    service = string
  }))
}

variable "google-apigee-organization" {
  description = "APIGEE project definition."
  type = map(object({
    project_id         = string
    analytics_region   = string
    authorized_network = string

    /*"projects/${var.project_id}/global/networks/${var.vpc_network}"
     -- example of how this gonna look
     */
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
    #runtime_ip_range = string
  }))
}

variable "google-apigee-environment-attachment" {
  type = map(object({
    environment = string
    instance_id = string
  }))
}