output "google-project-service-id" {
  value = {for k, v in google_project_service.this : k=> v.id}
}

output "google-apigee-organization-id" {
  value = { for k, v in google_apigee_organization.this : k => v.id }
}

output "google-apigee-environment-name" {
  value = {for k, v in google_apigee_environment.this : k=> v.name}
}

output "google-apigee-instance-id" {
  value = {for k, v in google_apigee_instance.this : k=> v.id}
}