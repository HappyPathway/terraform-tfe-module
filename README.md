# terraform-tfe-module
Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.2.1 |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_secret.secret](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_secret) | resource |
| [github_actions_variable.variable](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/actions_variable) | resource |
| [github_branch_default.default_main_branch](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch_default) | resource |
| [github_branch_protection.main](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.repo](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository) | resource |
| [github_repository_file.action_badges](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.codeowners](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.extra_files](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.github_actions](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.modtest_target_workspaces](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/repository_file) | resource |
| [github_team_repository.admin](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_repository) | resource |
| [github_team_repository.admins](https://registry.terraform.io/providers/hashicorp/github/latest/docs/resources/team_repository) | resource |
| [tfe_registry_module.public-registry-module](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_module) | resource |
| [tfe_registry_module.registry-module](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/registry_module) | resource |
| [github_organization_teams.root_teams](https://registry.terraform.io/providers/hashicorp/github/latest/docs/data-sources/organization_teams) | data source |
| [github_repository.repo](https://registry.terraform.io/providers/hashicorp/github/latest/docs/data-sources/repository) | data source |
| [tfe_oauth_client.client](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/oauth_client) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_codeowners"></a> [additional\_codeowners](#input\_additional\_codeowners) | Enable adding of Codeowner Teams | `list(any)` | `[]` | no |
| <a name="input_create_registry_module"></a> [create\_registry\_module](#input\_create\_registry\_module) | n/a | `bool` | `true` | no |
| <a name="input_extra_files"></a> [extra\_files](#input\_extra\_files) | Extra Files | <pre>list(object({<br>    path    = string,<br>    content = string<br>  }))</pre> | `[]` | no |
| <a name="input_github_actions"></a> [github\_actions](#input\_github\_actions) | n/a | <pre>object({<br>    username          = string<br>    email             = string<br>    org               = string<br>    terraform_version = optional(string, "1.9.1")<br>    terraform_api     = optional(string, "app.terraform.io")<br>    token             = optional(string)<br>    tfe_token         = optional(string)<br>    server            = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_github_allow_merge_commit"></a> [github\_allow\_merge\_commit](#input\_github\_allow\_merge\_commit) | n/a | `bool` | `false` | no |
| <a name="input_github_allow_rebase_merge"></a> [github\_allow\_rebase\_merge](#input\_github\_allow\_rebase\_merge) | n/a | `bool` | `false` | no |
| <a name="input_github_allow_squash_merge"></a> [github\_allow\_squash\_merge](#input\_github\_allow\_squash\_merge) | n/a | `bool` | `true` | no |
| <a name="input_github_auto_init"></a> [github\_auto\_init](#input\_github\_auto\_init) | n/a | `bool` | `true` | no |
| <a name="input_github_codeowners_team"></a> [github\_codeowners\_team](#input\_github\_codeowners\_team) | n/a | `string` | `"terraform-reviewers"` | no |
| <a name="input_github_create_repo"></a> [github\_create\_repo](#input\_github\_create\_repo) | Should we create the new repo, or does it already exist? | `bool` | `true` | no |
| <a name="input_github_default_branch"></a> [github\_default\_branch](#input\_github\_default\_branch) | n/a | `string` | `"main"` | no |
| <a name="input_github_delete_branch_on_merge"></a> [github\_delete\_branch\_on\_merge](#input\_github\_delete\_branch\_on\_merge) | n/a | `bool` | `true` | no |
| <a name="input_github_dismiss_stale_reviews"></a> [github\_dismiss\_stale\_reviews](#input\_github\_dismiss\_stale\_reviews) | n/a | `bool` | `true` | no |
| <a name="input_github_enforce_admins_branch_protection"></a> [github\_enforce\_admins\_branch\_protection](#input\_github\_enforce\_admins\_branch\_protection) | n/a | `bool` | `true` | no |
| <a name="input_github_has_issues"></a> [github\_has\_issues](#input\_github\_has\_issues) | n/a | `bool` | `false` | no |
| <a name="input_github_has_projects"></a> [github\_has\_projects](#input\_github\_has\_projects) | n/a | `bool` | `true` | no |
| <a name="input_github_has_wiki"></a> [github\_has\_wiki](#input\_github\_has\_wiki) | n/a | `bool` | `true` | no |
| <a name="input_github_is_private"></a> [github\_is\_private](#input\_github\_is\_private) | n/a | `bool` | `true` | no |
| <a name="input_github_org_teams"></a> [github\_org\_teams](#input\_github\_org\_teams) | provide module with list of teams so that module does not need to look them up | `list(any)` | `null` | no |
| <a name="input_github_repo_description"></a> [github\_repo\_description](#input\_github\_repo\_description) | n/a | `string` | `"Terraform Module"` | no |
| <a name="input_github_repo_topics"></a> [github\_repo\_topics](#input\_github\_repo\_topics) | Github Repo Topics | `list` | <pre>[<br>  "terraform",<br>  "module",<br>  "terraform-managed"<br>]</pre> | no |
| <a name="input_github_require_code_owner_reviews"></a> [github\_require\_code\_owner\_reviews](#input\_github\_require\_code\_owner\_reviews) | n/a | `bool` | `true` | no |
| <a name="input_github_required_approving_review_count"></a> [github\_required\_approving\_review\_count](#input\_github\_required\_approving\_review\_count) | n/a | `number` | `1` | no |
| <a name="input_is_template"></a> [is\_template](#input\_is\_template) | n/a | `bool` | `false` | no |
| <a name="input_mod_source"></a> [mod\_source](#input\_mod\_source) | n/a | `string` | `null` | no |
| <a name="input_modtest"></a> [modtest](#input\_modtest) | n/a | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the terraform workspace and optionally github repo | `any` | n/a | yes |
| <a name="input_oauth_service_provider"></a> [oauth\_service\_provider](#input\_oauth\_service\_provider) | n/a | `string` | `"github"` | no |
| <a name="input_org_admin_user"></a> [org\_admin\_user](#input\_org\_admin\_user) | n/a | `string` | `null` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | n/a | `string` | `"roknsound"` | no |
| <a name="input_public_module"></a> [public\_module](#input\_public\_module) | Is this a public module? | `bool` | `false` | no |
| <a name="input_public_organization"></a> [public\_organization](#input\_public\_organization) | Public Organization | `any` | `null` | no |
| <a name="input_pull_request_bypassers"></a> [pull\_request\_bypassers](#input\_pull\_request\_bypassers) | n/a | `list(any)` | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Github Action Secrets | <pre>list(object({<br>    name  = string,<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_target_workspaces"></a> [target\_workspaces](#input\_target\_workspaces) | n/a | <pre>list(object({<br>    workspace_repo   = string<br>    workspace_branch = string<br>    workspace        = string<br>    repo_clone_type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_template_repo"></a> [template\_repo](#input\_template\_repo) | n/a | `any` | `null` | no |
| <a name="input_template_repo_org"></a> [template\_repo\_org](#input\_template\_repo\_org) | n/a | `string` | `"HappyPathway"` | no |
| <a name="input_use_tags"></a> [use\_tags](#input\_use\_tags) | Will new tags trigger new module versions | `bool` | `true` | no |
| <a name="input_vars"></a> [vars](#input\_vars) | Github Action Vars | <pre>list(object({<br>    name  = string,<br>    value = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repo"></a> [github\_repo](#output\_github\_repo) | n/a |
<!-- END_TF_DOCS -->