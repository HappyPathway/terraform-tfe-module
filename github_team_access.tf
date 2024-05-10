# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
data "github_organization_teams" "root_teams" {
  count           = var.github_org_teams == null ? 1 : 0
  root_teams_only = false
}

locals {
  github_org_teams = var.github_org_teams == null ? data.github_organization_teams.root_teams[0].teams : var.github_org_teams
  github_teams     = { for obj in local.github_org_teams : "${obj.slug}" => obj.id }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository
resource "github_team_repository" "admins" {
  team_id    = lookup(local.github_teams, var.github_codeowners_team)
  repository = github_repository.repo.name
  permission = "admin"
  lifecycle {
    ignore_changes = [
      team_id
    ]
  }
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository
resource "github_team_repository" "nit_admin" {
  team_id    = lookup(local.github_teams, "terraform-reviewers")
  repository = github_repository.repo.name
  permission = "admin"
  lifecycle {
    ignore_changes = [
      team_id
    ]
  }
}