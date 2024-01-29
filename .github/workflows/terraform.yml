name: Terraform Apply

on:
  push:
    branches:
      - feature

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Set up Terraform
      uses: hashicorp/setup-terraform@v1
      with:
        terraform_version: 1.0.2

    - name: Configure AWS credentials
      uses: aws-actions/configure-aws-credentials@v2
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: ap-south-1  # Set your desired AWS region

    - name: Initialize Terraform
      id: init
      run: terraform init

    - name: Terraform Format
      id: fmt
      run: terraform fmt
      continue-on-error: true

    - name: Terraform Validate
      id: validate
      run: terraform validate -no-color

    - name: Terraform Plan
      id: plan
      run: terraform plan -no-color
      continue-on-error: true

    - uses: actions/github-script@v6
      if: github.event_name == 'pull_request'
      env:
        PLAN: "terraform\n${{ steps.plan.outputs.stdout }}"
      with:
        github-token: ${{ secrets.GITHUB_TOKEN }}
        script: |
          // 1. Retrieve existing bot comments for the PR
          const { data: comments } = await github.rest.issues.listComments({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: context.issue.number,
          })
          const botComment = comments.find(comment => {
            return comment.user.type === 'Bot' && comment.body.includes('Terraform Format and Style')
          })
    
          // 2. Prepare format of the comment
          const output = `#### Terraform Format and Style 🖌\`${{ steps.fmt.outcome }}\`
          #### Terraform Initialization ⚙️\`${{ steps.init.outcome }}\`
          #### Terraform Validation 🤖\`${{ steps.validate.outcome }}\`
          <details><summary>Validation Output</summary>
    
          \`\`\`\n
          ${{ steps.validate.outputs.stdout }}
          \`\`\`
    
          </details>
    
          #### Terraform Plan 📖\`${{ steps.plan.outcome }}\`
    
          <details><summary>Show Plan</summary>
    
          \`\`\`\n
          ${process.env.PLAN}
          \`\`\`
    
          </details>
    
          *Pusher: @${{ github.actor }}, Action: \`${{ github.event_name }}\`, Workflow: \`${{ github.workflow }}\`*`;
    
          // 3. If we have a comment, update it, otherwise create a new one
          if (botComment) {
            github.rest.issues.updateComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              comment_id: botComment.id,
              body: output
            })
          } else {
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: output
            })
          }

    #- name: Apply Terraform changes
    # run: terraform apply -auto-approve

    #- name: Clean up Terraform
    #  run: terraform destroy -auto-approve
