output "resource" {
  description = "Privileged Identity Management resource object."
  value       = azurerm_pim_eligible_role_assignment.main
}

output "id" {
  description = "Privileged Identity Management ID."
  value       = azurerm_pim_eligible_role_assignment.main.id
}

output "name" {
  description = "Privileged Identity Management name."
  value       = azurerm_pim_eligible_role_assignment.main.name
}

output "identity_principal_id" {
  description = "Privileged Identity Management system identity principal ID."
  value       = try(azurerm_pim_eligible_role_assignment.main.identity[0].principal_id, null)
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}
