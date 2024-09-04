locals {
  public_organization = var.public_organization == null ? var.organization : var.public_organization
}

resource "tfe_registry_module" "registry-module" {
  count = var.create_registry_module ? 1 : 0
  vcs_repo {
    display_identifier = local.github_repo.full_name
    identifier         = local.github_repo.full_name
    oauth_token_id     = local.oauth_token_id
    tags               = var.use_tags ? var.use_tags : null
  }
  depends_on = [github_repository.repo]
}



resource "tfe_registry_module" "public-registry-module" {
  count           = var.public_module ? 1 : 0
  organization    = local.public_organization
  namespace       = local.public_organization
  module_provider = split("-", var.name)[1]
  name            = join("-", slice(split("-", var.name), 2, length(split("-", var.name))))
  registry_name   = "public"
}
