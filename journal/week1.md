#  Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:
```
- PROJECT_ROOT
  |- variables.tf - stores the structure of the input variables.
  |- main.tf - everything else
  |- providers.tf - defined required providers and their configs
  |- outputs.tf - stores outputs
  |- terraform.tfvars - the data of variables we want to load into tf project
  |- README.md - required for root modules
```
[Standard Root Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Gotchas'

1. When setting the env vars in tf cloud, don't add the value within apostrophe's, leave the apostrophe's out.

2. The aws provider region needs to be added, in the terraform providers.

## Terraform and Input Variables
### Terraform Cloud  Variables

In tf we can set two kinds of variables:
- Environment Variables - those you would set in your bash terminal eg. AWS creds
- Terraform Variables - those that you would normally set in your tfvars file

We can set TF cloud variables to sensitive so they are not shown visibly. 

### Loading Terraform Input Variables

We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id"`

- TODO: research this flag (`-var-file`)

### terraform.tfvars

This is the default file to load in terraform variables in bulk

### auto.tfvars

- TODO: document this functionality for tf cloud

### order of terraform variables

- TODO: order of precedence



## Dealing with Configuration Drift

@@ What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform port import it wont for all cloud resources. You need to check the providers documentation for which resources support import.
### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name` or `import.tf`
If someone deletes or modifies cloud resources manually through ClickOps.
If we run `terraform plan`, it will attend to put our infra back into the expected state, by fixing the configuration drift. 

### Fix Manual Configuration