locals {
  codeowners = length(var.additional_codeowners) > 0 ? flatten(["${var.organization}/${var.github_codeowners_team}", formatlist("${var.organization}/%s", var.additional_codeowners)]) : ["${var.organization}/${var.github_codeowners_team}"]
}

data "tfe_oauth_client" "client" {
  organization     = var.organization
  service_provider = var.oauth_service_provider
}

locals {
  oauth_token_id = data.tfe_oauth_client.client.oauth_token_id
}