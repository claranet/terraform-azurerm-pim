data "azuread_user" "main" {
  for_each            = toset(local.all_pim_members)
  user_principal_name = each.key
}
