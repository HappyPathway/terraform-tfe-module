resource "github_repository_file" "github_actions" {
  count               = var.github_actions == null ? 0 : 1
  repository          = local.github_repo.name
  branch              = var.github_default_branch
  file                = ".github/workflows/terraform.yaml"
  content             = file("${path.module}/terraform.yaml")
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
      branch
    ]
  }
}

resource "github_repository_file" "modtest_target_workspaces" {
  for_each   = var.modtest ? toset(var.target_workspaces) : toset([])
  repository = local.github_repo.name
  branch     = var.github_default_branch
  file       = ".github/workflows/modtest-${each.value}.yaml"
  content = templatefile(
    "${path.module}/templates/target_workspace.yaml",
    {
      workspace        = each.value,
      mod_source       = "${tfe_registry_module.registry-module.name}/${tfe_registry_module.registry-module.module_provider}"
      workspace_repo   = each.value.workspace_repo
      workspace_branch = each.value.workspace_branch
      repo_clone_type  = each.value.repo_clone_type
    }
  )
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
      branch
    ]
  }
}


