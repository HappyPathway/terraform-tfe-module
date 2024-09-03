name: "Gtag"

on:
  workflow_dispatch:
  push:
    branches:
      - main
    
jobs:
  terraform:
    uses: HappyPathway/centralized-actions/.github/workflows/terraform-test.yml@main
    with:
      terraform_version: ${terraform_version}
      terraform_api: ${terraform_api}
      github_username: ${github_username}
      github_email: ${github_email}
      github_org: ${github_org}
    secrets:
      TFE_TOKEN: $${{ secrets.TFE_TOKEN }}
      GH_TOKEN: $${{ secrets.GH_TOKEN }}

  gtag:
    needs: terraform
    uses: HappyPathway/centralized-actions/.github/workflows/gtag.yml@main
    with:
      patch: true
      github_org: ${github_org}
      github_username: ${github_username}
      github_email: ${github_email}
    secrets:
      GH_TOKEN: $${{ secrets.GH_TOKEN }}
