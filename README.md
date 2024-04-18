# Github ARC

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>2.40.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.99.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~>2.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.40.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.99.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.arc_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.arc_cluster_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.arc_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.arc_scale_set](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_user_assigned_identity.azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | The number of nodes in the default node pool | `number` | n/a | yes |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | The size of the default node pool | `string` | `"Standard_B2als_v2"` | no |
| <a name="input_github_pat"></a> [github\_pat](#input\_github\_pat) | GitHub Personal Access Token | `string` | n/a | yes |
| <a name="input_github_url"></a> [github\_url](#input\_github\_url) | Organization GitHub URL | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource group | `string` | n/a | yes |
| <a name="input_managed_identity_name"></a> [managed\_identity\_name](#input\_managed\_identity\_name) | Managed identity name for the AKS cluster | `string` | n/a | yes |
| <a name="input_managed_identity_rg"></a> [managed\_identity\_rg](#input\_managed\_identity\_rg) | Resource group name containing the managed identity | `string` | n/a | yes |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | The size of the os disk | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Cluster SSH key | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | AKS cluster tags | `map(string)` | n/a | yes |

## Outputs

No outputs.

# Terrakube

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~>2.40.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.99.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~>2.13.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.40.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.99.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.13.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.tk_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_resource_group.tk_cluster_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [helm_release.terrakube](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_user_assigned_identity.azure](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_node_pool_node_count"></a> [default\_node\_pool\_node\_count](#input\_default\_node\_pool\_node\_count) | The number of nodes in the default node pool | `number` | n/a | yes |
| <a name="input_default_node_pool_vm_size"></a> [default\_node\_pool\_vm\_size](#input\_default\_node\_pool\_vm\_size) | The size of the default node pool | `string` | `"Standard_B2als_v2"` | no |
| <a name="input_github_pat"></a> [github\_pat](#input\_github\_pat) | GitHub Personal Access Token | `string` | n/a | yes |
| <a name="input_github_url"></a> [github\_url](#input\_github\_url) | Organization GitHub URL | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the resource group | `string` | n/a | yes |
| <a name="input_managed_identity_name"></a> [managed\_identity\_name](#input\_managed\_identity\_name) | Managed identity name for the AKS cluster | `string` | n/a | yes |
| <a name="input_managed_identity_rg"></a> [managed\_identity\_rg](#input\_managed\_identity\_rg) | Resource group name containing the managed identity | `string` | n/a | yes |
| <a name="input_os_disk_size"></a> [os\_disk\_size](#input\_os\_disk\_size) | The size of the os disk | `number` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | Cluster SSH key | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | AKS cluster tags | `map(string)` | n/a | yes |

## Outputs

No outputs.
