resource "github_repository" "repo" {
  count                  = var.github_create_repo ? 1 : 0
  name                   = var.name
  description            = var.github_repo_description
  visibility             = var.github_is_private ? "private" : "public"
  auto_init              = var.github_auto_init
  allow_merge_commit     = var.github_allow_merge_commit
  allow_squash_merge     = var.github_allow_squash_merge
  allow_rebase_merge     = var.github_allow_rebase_merge
  archive_on_destroy     = true
  delete_branch_on_merge = var.github_delete_branch_on_merge
  has_projects           = var.github_has_projects
  has_issues             = var.github_has_issues
  has_wiki               = var.github_has_wiki
  topics                 = var.github_repo_topics
  gitignore_template     = "Terraform"
  is_template            = var.is_template
  # lifecycle {
  #   ignore_changes = [
  #     name
  #   ]
  # }
  dynamic "template" {
    # A bogus map for a conditional block
    for_each = var.template_repo == null ? [] : ["*"]
    content {
      owner      = var.template_repo_org
      repository = var.template_repo
    }
  }
}

data github_repository repo {
  count                  = var.github_create_repo ? 0 : 1
  name                   = var.name
}

locals {
  github_repo = var.github_create_repo ? github_repository.repo : data.github_repository.repo
}