module "pim" {
  source  = "claranet/pim/azurerm"
  version = "x.x.x"

  pim_enabled_groups = {
    "Tenant Global Administrators Group" = {
      members = [
        "user.mail@tenantname.onmicrosoft.com",
        "guest.user_guest.domaine#EXT#@tenantname.onmicrosoft.com",
      ]
      roles = ["Global Administrator"]
    }
    "Existing Group" = {
      members = [
        "member1@tenantname.onmicrosoft.com",
        "member2@tenantname.onmicrosoft.com",
      ]
      roles        = ["Security Operator", "Cloud App Security Administrator"]
      create_group = false
    }
  }
}
