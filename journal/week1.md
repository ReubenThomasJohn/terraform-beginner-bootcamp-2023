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

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrastructure back into the expected state fixing Configuration Drift

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Dealing with Configuration Drift

@@ What happens if we lose our state file?

If you lose your statefile, you most likely have to tear down all your cloud infrastructure manually.

You can use terraform port import it wont for all cloud resources. You need to check the providers documentation for which resources support import.
### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name` or `import.tf`
 

### Fix Manual Configuration
If someone deletes or modifies cloud resources manually through ClickOps.
If we run `terraform plan`, it will attend to put our infra back into the expected state, by fixing the configuration drift.

## Terraform Modules

### Terraform Module Structure

It is recommend to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```


[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Working with Files in Terraform

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:

- path.root
- path.module
- path.cwd 
- etc.

### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}
```

### Terraform Locals
They allow us to define local variables.
It can be very useful when we need to transform data into another format and have it referenced as a variable. 


### Data Sources

This allows us to source data from cloud resources. It is useful when we want to reference cloud resources without importing them.

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

### Working with JSON

`jsonencode` is a terraform function to add JSON data in-line in the hcl.

### Changing the lifecycle of a resource

[Meta Arguments](https://developer.hashicorp.com/terraform/tutorials/state/resource-lifecycle)

## Provisioners

Provisioners allow to execute commands on compute instances eg. a AWS CLI command. 

They are not recommended for use by Hashicorp because Configuration Management tools like Ansible are a better fit, but the functionality still exists. 

### Local-exec

This will execute a command on the machine running the terraform commands.
eg. terraform plan, tf apply.

### Remote-exec

This will execute commands on a machine which you target. You need to provide credentials to access the targeted machine. 

## For Each Expressions

This can be used for a lot of cases, and is very important to be good at.
It allows us to enumerate over complex data structures.
It is mostly useful when creating multiples of a cloud resource and want to reduce that amount of repetitive terraform code. 

[For each expressions](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)