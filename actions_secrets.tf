resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in var.secrets : secret.name => secret.value })
  secret_name     = each.key
  plaintext_value = each.value
  repository      = local.github_repo.name
}

locals {
  vars = concat(var.vars,
    var.github_actions == null ? [] : [
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
      }
  ])
}
resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in local.vars : _var.name => _var.value })
  repository    = local.github_repo.name
  variable_name = each.key
  value         = each.value
}
