resource "google_project_service" "this" {
  for_each = var.google-project-service
  project = each.value.project
  service = each.value.service
}

resource "google_apigee_organization" "this" {
  for_each = var.google-apigee-organization
  project_id        = each.value.project_id
  analytics_region  = each.value.analytics_region
  authorized_network = "projects/${each.value.authorized_network}/global/networks"

 # depends_on = [google_project_service.this]
}

resource "google_apigee_environment" "this" {
  for_each = var.google-apigee-environment
  org_id = each.value.org_id
  name   = each.value.name

 # depends_on = [google_apigee_organization.this.id]
}

resource "google_apigee_instance" "this" {
  for_each = var.google-apigee-instance
  name            = each.value.name
  org_id          = each.value.org_id
  location        = each.value.location
  #runtime_ip_range = each.value.runtime_ip_range

  #depends_on = [google_apigee_organization.this]
}

resource "google_apigee_instance_attachment" "this" {
  for_each = var.google-apigee-environment-attachment
  environment     = each.value.environment
  instance_id     = each.value.instance_id

}