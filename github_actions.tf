resource "github_repository_file" "github_actions" {
  count               = var.github_actions == null ? 0 : 1
  repository          = local.github_repo.name
  branch              = var.github_default_branch
  file                = ".github/workflows/terraform.yaml"
  content             = file("${path.module}/terraform.yaml")
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      branch,
      content
    ]
  }
}


locals {
  mod_source = var.create_registry_module ? "${one(tfe_registry_module.registry-module).name}/${one(tfe_registry_module.registry-module).module_provider}" : var.mod_source
  _action_badges = concat([
    {
      name  = "terraform.yaml",
      title = "Terraform Validation"
    }
    ],
    [
      for workspace in var.target_workspaces :
      {
        name  = "modtest-${workspace.workspace}.yaml",
        title = "Modtest ${workspace.workspace}"
      }
    ]
  )
  action_badges = var.github_actions == null ? [] : [
    for badge in local._action_badges :
    templatefile("${path.module}/templates/badge.tpl",
      {
        title       = title(badge.title),
        repo_name   = local.github_repo.name,
        action_name = badge.name
        server      = var.github_actions.server
    })
  ]
}

resource "github_repository_file" "action_badges" {
  count               = var.github_actions == null ? 0 : 1
  repository          = local.github_repo.name
  branch              = var.github_default_branch
  file                = "README.md"
  content             = join("\n", local.action_badges)
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      branch,
      content
    ]
  }
}

resource "github_repository_file" "modtest_target_workspaces" {
  for_each   = var.modtest ? tomap({ for workspace in var.target_workspaces : workspace.workspace => workspace }) : tomap({})
  repository = local.github_repo.name
  branch     = var.github_default_branch
  file       = ".github/workflows/modtest-${each.value.workspace}.yaml"
  content = templatefile(
    "${path.module}/templates/target_workspace.yaml",
    {
      workspace        = each.value.workspace,
      mod_source       = local.mod_source
      workspace_repo   = each.value.workspace_repo
      workspace_branch = each.value.workspace_branch
      repo_clone_type  = each.value.repo_clone_type
    }
  )
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      branch
    ]
  }
}


