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
      terraform_version: ${{vars.TERRAFORM_VERSION}}
      terraform_api: ${{vars.TERRAFORM_API}}
      github_username: ${{vars.GITHUB_USERNAME}}
      github_email: ${{vars.GITHUB_EMAIL}}
      github_org: ${{ vars.GITHUB_ORG }}
    secrets:
      TFE_TOKEN: ${{ secrets.TFE_TOKEN }}
      GH_TOKEN: ${{ secrets.GH_TOKEN }}

  gtag:
    needs: terraform
    uses: HappyPathway/centralized-actions/.github/workflows/gtag.yml@main
    with:
      patch: true
      github_org: ${{ vars.GITHUB_ORG }}
      github_username: ${{ vars.GITHUB_USERNAME }}
      github_email: ${{ vars.GITHUB_EMAIL }}}
    secrets:
      GH_TOKEN: ${{ secrets.GH_TOKEN }}
