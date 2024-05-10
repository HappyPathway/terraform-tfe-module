resource "tfe_registry_module" "registry-module" {
  vcs_repo {
    display_identifier = github_repository.repo.full_name
    identifier         = github_repository.repo.full_name
    oauth_token_id     = local.oauth_token_id
  }
}
