resource "tfe_registry_module" "registry-module" {
  vcs_repo {
    display_identifier = local.github_repo.full_name
    identifier         = local.github_repo.full_name
    oauth_token_id     = local.oauth_token_id
    tags               = var.use_tags ? var.use_tags : null
  }
  depends_on = [ github_repository.repo ]
}
