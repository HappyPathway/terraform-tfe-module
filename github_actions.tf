# This file defines GitHub Actions workflows and badges for the repository.

locals {
  inherited_actions_workflows = [{
    title = "Terraform Validation"
    name  = "terraform.yaml"
    },
    {
      title = "Terraform Doc"
      name  = "terraform-doc.yaml"
  }]
}

resource "github_repository_file" "github_actions" {
  for_each            = toset(var.github_actions == null ? [] : [for wf in local.inherited_actions_workflows : wf.name]) # Only create this resource if github_actions variable is not null.
  repository          = local.github_repo.name                                                                           # The name of the repository where the file will be created.
  branch              = var.github_default_branch                                                                        # The branch where the file will be created.
  file                = ".github/workflows/${each.key}"                                                                  # The path to the file in the repository.
  content             = file("${path.module}/workflows/${each.key}")                                                     # The content of the file, read from a local file.
  overwrite_on_create = true                                                                                             # Overwrite the file if it already exists.
  lifecycle {
    ignore_changes = [
      branch
    ]
  }
}

locals {
  mod_source = var.create_registry_module ? "${one(tfe_registry_module.registry-module).name}/${one(tfe_registry_module.registry-module).module_provider}" : var.mod_source # Determine the module source based on whether a registry module is created.

  _action_badges = concat(local.inherited_actions_workflows,
    [
      for workspace in var.target_workspaces :
      {
        name  = "modtest-${workspace.workspace}.yaml",
        title = "Modtest ${workspace.workspace}"
      }
    ]
  ) # Define the action badges for the workflows.

  action_badges = var.github_actions == null ? [] : [
    for badge in local._action_badges :
    templatefile("${path.module}/templates/badge.tpl",
      {
        title       = title(badge.title),
        repo_name   = local.github_repo.name,
        action_name = badge.name,
        server      = var.github_actions.server,
        org         = var.github_actions.org
    })
  ] # Generate the action badges if GitHub Actions is enabled.
}

resource "github_repository_file" "action_badges" {
  count      = var.github_actions == null ? 0 : 1 # Only create this resource if github_actions variable is not null.
  repository = local.github_repo.name             # The name of the repository where the file will be created.
  branch     = var.github_default_branch          # The branch where the file will be created.
  file       = "README.md"                        # The path to the file in the repository.
  content = templatefile(
    "${path.module}/templates/readme.tpl",
    {
      badges = join("\n", local.action_badges)
    }
  )                          # The content of the file, generated from a template.
  overwrite_on_create = true # Overwrite the file if it already exists.
  lifecycle {
    ignore_changes = [branch, content] # Ignore changes to the branch and content attributes.
  }
}

resource "github_repository_file" "modtest_target_workspaces" {
  for_each   = var.modtest ? tomap({ for workspace in var.target_workspaces : workspace.workspace => workspace }) : tomap({}) # Create a resource for each target workspace if modtest variable is true.
  repository = local.github_repo.name                                                                                         # The name of the repository where the file will be created.
  branch     = var.github_default_branch                                                                                      # The branch where the file will be created.
  file       = ".github/workflows/modtest-${each.value.workspace}.yaml"                                                       # The path to the file in the repository.
  content = templatefile(
    "${path.module}/templates/target_workspace.yaml",
    {
      workspace        = each.value.workspace,
      mod_source       = local.mod_source,
      workspace_repo   = each.value.workspace_repo,
      workspace_branch = each.value.workspace_branch,
      repo_clone_type  = each.value.repo_clone_type
    }
  )                          # The content of the file, generated from a template.
  overwrite_on_create = true # Overwrite the file if it already exists.
  lifecycle {
    ignore_changes = [branch] # Ignore changes to the branch attribute.
  }
}


