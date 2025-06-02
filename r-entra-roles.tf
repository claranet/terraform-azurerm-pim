resource "azuread_directory_role" "main" {
  for_each     = toset(local.pim_roles)
  display_name = each.key
}
