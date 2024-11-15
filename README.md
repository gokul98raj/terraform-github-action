# Terraform GitHub Actions for Automated Infrastructure Deployment

This repository contains Terraform configurations, automated using GitHub Actions. Changes committed to this repository will trigger GitHub Actions to manage the infrastructure defined in Terraform.

## Prerequisites

1. **Terraform Files**: Ensure `.tf` files are set up in this repository.
2. **GitHub Secrets**: Store required environment secrets in your GitHub repository settings under **Settings > Secrets and variables > Actions**.
   - `AWS_ACCESS_KEY_ID`: AWS access key.
   - `AWS_SECRET_ACCESS_KEY`: AWS secret key.
   - Any other credentials required by your provider.

## GitHub Actions Workflow

The workflow runs automatically on each push or pull request to the `main` branch (this can be adjusted as needed).

### Workflow Steps

1. **Setup**: Configures Terraform and AWS credentials.
2. **Formatting Check**: Ensures Terraform code adheres to formatting standards.
3. **Validation**: Checks Terraform syntax and configuration.
4. **Plan**: Runs `terraform plan` to preview changes.
5. **Apply**: Applies changes to update infrastructure if approved (typically on the `main` branch).

## Usage

- **Apply Changes**: Push or create a pull request to the `main` branch. GitHub Actions will validate and apply the Terraform configuration if there are any changes.
- **Review Changes**: For branches other than `main`, the workflow will only run `terraform plan` to preview proposed changes.

## Notes

- This setup supports automated infrastructure deployment for AWS. Modify the workflow file as needed for other providers or additional custom steps.
- To review deployment logs, go to the **Actions** tab in your GitHub repository.
