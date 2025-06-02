locals {
  all_pim_members = distinct(flatten([
    for grp_name, grp_value in var.pim_enabled_groups : grp_value.members
  ]))

  pim_roles = distinct(flatten([
    for grp_name, grp_value in var.pim_enabled_groups : grp_value.roles
  ]))
}
