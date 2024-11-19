variable "name" {
  description = "Name of the terraform workspace and optionally github repo"
}
variable "organization" {
  default = "roknsound"
}

variable "github_codeowners_team" {
  default = "terraform-reviewers"
}

variable "github_repo_description" {
  default = "Terraform Module"
}

variable "github_repo_topics" {
  description = "Github Repo Topics"
  default = [
    "terraform",
    "module",
    "terraform-managed"
  ]
}
variable "github_is_private" {
  default = true
}
variable "github_auto_init" {
  default = true
}
variable "github_allow_merge_commit" {
  default = false
}
variable "github_allow_squash_merge" {
  default = true
}
variable "github_allow_rebase_merge" {
  default = false
}
variable "github_delete_branch_on_merge" {
  default = true
}
variable "github_has_projects" {
  default = true
}
variable "github_has_issues" {
  default = false
}
variable "github_has_wiki" {
  default = true
}
variable "github_default_branch" {
  default = "main"
}
variable "github_required_approving_review_count" {
  default = 1
}
variable "github_require_code_owner_reviews" {
  default = true
}
variable "github_dismiss_stale_reviews" {
  default = true
}
variable "github_enforce_admins_branch_protection" {
  default = true
}

variable "additional_codeowners" {
  description = "Enable adding of Codeowner Teams"
  type        = list(any)
  default     = []
}

variable "github_org_teams" {
  type        = list(any)
  description = "provide module with list of teams so that module does not need to look them up"
  default     = null
}

variable "template_repo_org" {
  default = "HappyPathway"
}

variable "template_repo" {
  default = null
}

variable "is_template" {
  default = false
}

variable "pull_request_bypassers" {
  default = []
  type    = list(any)
}


variable "secrets" {
  type = list(object({
    name  = string,
    value = string
  }))
  default     = []
  description = "Github Action Secrets"
}

variable "vars" {
  type = list(object({
    name  = string,
    value = string
  }))
  default     = []
  description = "Github Action Vars"
}

variable "extra_files" {
  type = list(object({
    path    = string,
    content = string
  }))
  default     = []
  description = "Extra Files"
}

variable "org_admin_user" {
  default = null
  type    = string
}

variable "oauth_service_provider" {
  default = "github"
}

variable "github_create_repo" {
  type        = bool
  default     = true
  description = "Should we create the new repo, or does it already exist?"
}

variable "use_tags" {
  default     = true
  description = "Will new tags trigger new module versions"
}

variable "public_organization" {
  default     = null
  description = "Public Organization"
}

variable "public_module" {
  default     = false
  description = "Is this a public module?"
}

variable "github_actions" {
  type = object({
    username          = string
    email             = string
    org               = string
    terraform_version = optional(string, "1.9.1")
    terraform_api     = optional(string, "app.terraform.io")
    token             = optional(string)
    tfe_token         = optional(string)
    server            = optional(string, "github.com")
  })
  default = null
}


variable "target_workspaces" {
  type = list(object({
    workspace_repo   = string
    workspace_branch = string
    workspace        = string
    repo_clone_type  = string
  }))
  default = []
}

variable "modtest" {
  type    = bool
  default = false
}

variable "create_registry_module" {
  type    = bool
  default = true
}

variable "mod_source" {
  type    = string
  default = null
}

variable enforce_prs {
  type = bool
  default = true
}
