resource "azuread_directory_role_eligibility_schedule_request" "main" {
  for_each = {
    for pair in flatten([
      for group_name, group_values in var.pim_enabled_groups : [
        for role in group_values.roles : {
          key   = "${group_name}-${role}"
          group = group_name
          role  = role
        }
      ]
    ]) : pair.key => pair
  }

  directory_scope_id = "/"
  justification      = "Initial Setup Assignments"
  principal_id = try(
    azuread_group_without_members.main[each.value.group].object_id,
    data.azuread_group.main[each.value.group].object_id
  )
  role_definition_id = azuread_directory_role.main[each.value.role].template_id
}
