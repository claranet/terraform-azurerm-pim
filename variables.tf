variable "pim_enabled_groups" {
  type = map(object({
    roles                    = list(string)
    members                  = list(string)
    create_group             = optional(bool, true)
    custom_group_description = optional(string, null)
  }))
  description = "Managed PIM groups with roles and members."
  nullable    = false
}
