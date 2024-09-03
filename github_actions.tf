resource "github_repository_file" "github_actions" {
  count               = var.github_actions == null ? 0 : 1
  repository          = local.github_repo.name
  branch              = var.github_default_branch
  file                = ".github/workflows/terraform.yaml"
  content             = file("${path.module}/terraform.yaml.tpl")
  overwrite_on_create = true
  lifecycle {
    ignore_changes = [
      content,
      branch
    ]
  }
}

locals {
    mod_source = slice(split("-", var.name), 1, length(split("-", var.name)) - 1)
    provider = mod_source[0]
    module = join("-", [ for mod_part in range(0, ): mod_source[1]
}

resource "github_repository_file" "modtest_target_workspaces" {
  for_each   = toset(var.target_workspaces)
  repository = local.github_repo.name
  branch     = var.github_default_branch
  file       = ".github/workflows/modtest-${each.value}.yaml"
  content = templatefile(
    "${path.module}/templates/target_workspace.yaml.tpl",
    {
         workspace = each.value,
         mod_source = "${tfe_registry_module.registry-module.name}/${tfe_registry_module.registry-module.module_provider}"
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

