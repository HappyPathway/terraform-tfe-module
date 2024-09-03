name: "ModTest: ${workspace}"

on:
  pull_request:
    branches:
      - main
    
jobs:
  modtest:
    uses: HappyPathway/centralized-actions/.github/workflows/modtest.yml@main
    with:
       workspace: ${workspace}
       github_server: $${{vars.GITHUB_SERVER}}
       github_org:  $${{ github.repository_owner }} 
       mod_source: ${mod_source}
       branch: $${{ github.head_ref }}
       terraform_version: $${vars.TERRAFORM_VERSION}
    secrets:
      TFE_TOKEN: $${{ secrets.TFE_TOKEN }}
      GH_TOKEN: $${{ secrets.GH_TOKEN }}