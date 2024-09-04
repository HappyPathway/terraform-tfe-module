resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  secret_name     = each.key
  plaintext_value = each.value
  repository      = local.github_repo.name
}

locals {
  secrets = var.target_workspaces == [] ? var.secrets : concat(var.secrets,
    lookup(var.github_actions, "token", null) == null ? [] :
    [
      {
        name  = "GH_TOKEN"
        value = var.github_actions.token
      }
    ],
    lookup(var.github_actions, "tfe_token", null) == null ? [] : [
      {
        name  = "TFE_TOKEN"
        value = var.github_actions.server
      }
    ]
  )
  vars = var.target_workspaces == [] ? var.vars : concat(var.vars,
    lookup(var.github_actions, "server", null) == null ? [] : [
      {
        name  = "GITHUB_SERVER"
        value = var.github_actions.server
      }
    ],
    [
      {
        name  = "GH_USERNAME"
        value = var.github_actions.username
      },
      {
        name  = "GH_EMAIL"
        value = var.github_actions.email
      },
      {
        name  = "GH_ORG"
        value = var.github_actions.org
      },
      {
        name  = "TERRAFORM_VERSION"
        value = var.github_actions.terraform_version
      },
      {
        name  = "TERRAFORM_API"
        value = var.github_actions.terraform_api
      },
      {
        name  = "TERRAFORM_API_TOKEN_NAME"
        value = replace(var.github_actions.terraform_api, ".", "_")
      }
    ]
  )
}
resource "github_actions_variable" "variable" {
  for_each      = var.modtest ? tomap({ for _var in local.vars : _var.name => _var.value }) : tomap({})
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
}
