resource "tfe_registry_module" "registry-module" {
  vcs_repo {
    display_identifier = local.github_repo.full_name
    identifier         = local.github_repo.full_name
    oauth_token_id     = local.oauth_token_id
  }
  depends_on = [ github_repository.repo ]
}
