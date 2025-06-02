data "azuread_group" "main" {
  for_each     = { for grp_name, grp_value in var.pim_enabled_groups : grp_name => grp_value if !grp_value.create_group }
  display_name = each.key
}
