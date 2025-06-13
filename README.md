# Privileged Identity Management
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/pim/azurerm/latest)

Azure module to deploy a [Privileged Identity Management](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure).

## Prerequisites
This module can only be applied with a Service Principal due to limitations with the Azure CLI and the AzureRM provider:
* https://github.com/Azure/azure-cli/issues/22775
* https://github.com/Azure/azure-cli/issues/26471

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azuread | ~> 3.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_directory_role.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) | resource |
| [azuread_directory_role_eligibility_schedule_request.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_eligibility_schedule_request) | resource |
| [azuread_group_member.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_without_members.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_without_members) | resource |
| [azuread_group.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_user.main](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/user) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| pim\_enabled\_groups | Managed PIM groups with roles and members. | <pre>map(object({<br/>    roles                    = list(string)<br/>    members                  = list(string)<br/>    create_group             = optional(bool, true)<br/>    custom_group_description = optional(string, null)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| resource | Privileged Identity Management resource object. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [PIM](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-configure)
