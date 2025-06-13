resource "azuread_group_without_members" "main" {
  for_each                = { for grp_name, grp_value in var.pim_enabled_groups : grp_name => grp_value if grp_value.create_group }
  display_name            = each.key
  description             = each.value.custom_group_description != null ? each.value.custom_group_description : "PIM Group for ${join(", ", each.value.roles)} role(s) assignments"
  owners                  = null
  prevent_duplicate_names = true
  mail_enabled            = false
  security_enabled        = true
  assignable_to_role      = true
}

resource "azuread_group_member" "main" {
  for_each = {
    for pair in flatten([
      for group_key, group in var.pim_enabled_groups : [
        for member in try(group.members, []) : {
          group_key = group_key
          member    = member
          id        = "${group_key}-${member}"
        }
      ]
    ]) : pair.id => pair
  }

  group_object_id = try(
    azuread_group_without_members.main[each.value.group_key].object_id,
    data.azuread_group.main[each.value.group_key].object_id
  )

  member_object_id = data.azuread_user.main[each.value.member].object_id
}
