# This file defines the GitHub Actions secrets and variables for the repository.

locals {
  secrets = concat(var.secrets,
    # If the GitHub Actions token is provided, add it to the secrets list.
    lookup(var.github_actions, "token", null) == null ? [] : [
      {
        name  = "GH_TOKEN",
        value = var.github_actions.token
      }
    ],
    # If the TFE token is provided, add it to the secrets list.
    # Combine the provided secrets with additional GitHub Actions tokens if available.
    lookup(var.github_actions, "tfe_token", null) == null ? [] : [
      {
        name  = "TFE_TOKEN",
        value = var.github_actions.server
      }
    ]
  )

  vars = concat(var.vars,
    lookup(var.github_actions, "server", null) == null ? [] : [
      {
        name  = "GH_SERVER",
        value = var.github_actions.server
      }
    ],
    # If the GitHub Actions server is provided, add it to the variables list.
    # Add the GitHub Actions username, email, organization, Terraform version, and API to the variables list.
    [
      {
        name  = "GH_USERNAME",
        value = var.github_actions.username
      },
      {
        name  = "GH_EMAIL",
        value = var.github_actions.email
      },
      {
        name  = "GH_ORG",
        value = var.github_actions.org
      },
      {
        name  = "TERRAFORM_VERSION",
        value = var.github_actions.terraform_version
      },
      {
        name  = "TERRAFORM_API",
        value = var.github_actions.terraform_api
      },
      {
        name  = "TERRAFORM_API_TOKEN_NAME",
        value = replace(var.github_actions.terraform_api, ".", "_")
      },
    ]
  )
}

resource "github_actions_secret" "secret" {
  for_each        = tomap({ for secret in local.secrets : secret.name => secret.value }) # Create a resource for each secret in the secrets list.
  secret_name     = each.key                                                             # The name of the secret.
  plaintext_value = each.value                                                           # The value of the secret.
  repository      = local.github_repo.name                                               # The name of the repository where the secret will be created.
}

resource "github_actions_variable" "variable" {
  for_each      = tomap({ for _var in local.vars : _var.name => _var.value }) # Create a resource for each variable in the variables list.
  repository    = local.github_repo.name                                      # The name of the repository where the variable will be created.
  variable_name = each.key                                                    # The name of the variable.
  value         = each.value                                                  # The value of the variable.
}
