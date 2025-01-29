
# https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/team
# data "github_team" "github_codeowners_team" {
#   slug = var.github_codeowners_team
# }

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_default
resource "github_branch_default" "default_main_branch" {
  repository = local.github_repo.name
  branch     = var.github_default_branch
  lifecycle {
    ignore_changes = [
      branch
    ]
  }
}

locals {
  pull_request_bypassers = distinct(concat(var.pull_request_bypassers, var.org_admin_user != null ? ["/${var.org_admin_user}"] : []))
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection
resource "github_branch_protection" "main" {
  count          = var.enforce_prs ? 1 : 0
  enforce_admins = var.github_enforce_admins_branch_protection
  pattern        = local.github_repo.default_branch
  repository_id  = local.github_repo.node_id
  required_pull_request_reviews {
    dismiss_stale_reviews           = var.github_dismiss_stale_reviews
    require_code_owner_reviews      = var.github_require_code_owner_reviews
    required_approving_review_count = var.github_required_approving_review_count
    pull_request_bypassers          = local.pull_request_bypassers
  }
  lifecycle {
    ignore_changes = [
      required_status_checks[0].contexts
    ]
  }
  depends_on = [
    # first let the automation create the codeowners and backend file then only create branch protection rule
    # if branch protection rule is created first, codeowners will fail
    github_repository_file.codeowners
  ]
}
