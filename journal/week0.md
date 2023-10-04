# Terraform Beginner Bootcamp 2023 - Week 0

- [Semantic Versioning](#semantic-versioning)
- [General workflow: (Needs to be updated)](#general-workflow---needs-to-be-updated-)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang](#shebang)
    + [Execution](#execution)
    + [Linux Permissions](#linux-permissions)
    + [Gitpod Lifecycle (Before, Init, Command)](#gitpod-lifecycle--before--init--command-)
  * [Working Env Vars](#working-env-vars)
    + [env command](#env-command)
    + [Setting and unsetting env vars](#setting-and-unsetting-env-vars)
    + [Printing vars](#printing-vars)
    + [Scoping of env vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [`Terraform Init`](#-terraform-init-)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
  * [Terraform Lock Files](#terraform-lock-files)
  * [Terraform State Files](#terraform-state-files)
  * [Terraform Directory](#terraform-directory)
- [Issues with Terraform Cloud and Gitpod Workspace](#issues-with-terraform-cloud-and-gitpod-workspace)
- [Serving up a static page](#serving-up-a-static-page)
  * [Upload a local file to an AWS S3 bucket](#upload-a-local-file-to-an-aws-s3-bucket)
  * [Accessing statically-hosted webpage](#accessing-statically-hosted-webpage)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>



## Semantic Versioning

This project will utilize semantic versioning for its tagging.

Refer: [semver.org](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH**, increment the:

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

---

## General workflow: (Needs to be updated)

1. Open an issue, keep the issue heading short
2. Create a new branch with the same name as the issue.
3. Create a commit with the number of the issue prefixed with the commit message.
4. Open PR to merge into main.
5. After PR is merged into main, tag and push the tag.

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The terraform CLI instructions have changed due to gpg keyring changes. So the original gitpod.yml was changed to run a bash script with the latest installation commands from:
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux distribution and change accordingly to distribution needs. Use `cat /etc/os-release`

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the CLI.

The file is located here: [bin/install_terraform_cli.bash](bin/install_terraform_cli.sh)

- This will keep the task file ([.gitpod.yml](.gitpod.yml))tidy.
- This allow us better portability
- Easier debugging. 

#### Shebang

A shebang tells the bash script what program will interpret the script.

#### Execution

When executing the bash script, we can use `./name_of_script` shorthand notation.

More portability from using `#!/usr/bin/env bash`

#### Linux Permissions

First we need to run `chmod u+x bin/install_terraform_cli` or `chmod 744 bin/install_terraform_cli` in order to make the script executable. This way, the file is given permission to be executed by the `user`.

#### Gitpod Lifecycle (Before, Init, Command)

We need to be careful when using `Init` because it does not re-run when opening an existing workspace. [Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks) 

### Working Env Vars
#### env command
We can list out all environment variables (env vars) using the `env` command

We can filter specific env vars using grep eg. `env | greo AWS_`

#### Setting and unsetting env vars

In the terminal we can set using `export HELLO='world'`

We can unset using `unset HELLO`

We can set an env var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message

```
Within a bash script we can set env without writing export eg.


```sh
#!/usr/bin/env bash
HELLO='world'
echo $HELLO
```

#### Printing vars

We can print an env var using echo eg. `echo $HELLO`

#### Scoping of env vars

When you open new bash terminals, the new ones will not be aware of env vars set in previous windows.

To persist env vars, across terminals that are open, env vars need to be set in bash profile.eg. `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars. 

## AWS CLI Installation

AWS CLI is installed for this project via bash script ['./bin/install_aws_cli.sh](./bin/install_aws_cli.sh)

[Getting started AWS CLI install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI env vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if AWS creds are configured correctly by running the following command:

```sh
aws sts get-caller-identity
```

If it is successful, you should see a json payload return that looks like this:

```json
{
    "UserId": "AAAAZVZEK4SVOZ7ECZZZZ",
    "Account": "665259111138",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the terraform registry which is location at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** are interfaces to APIs that allow us to create resources in terraform
- **Modules** are a way to make large amounts of terraform code modular, portable and shareable.

### Terraform Console

We can see a list of all the tf commands by simple typing `terraform`

#### `Terraform Init`
At the start of a new tf project, we will run `terraform init` to download the binaries for the terraform providers that we'll use in the project. 

#### Terraform Plan

This will generate a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can ignore outputting.

#### Terraform Apply

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us yes or no.

If we want to automatically approve an apply, we can provide the auto approve flag. ie. `terraform apply --auto-approve`

### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versionining for the providers or modules that should be used witrh this project.

The Terraform Lock file should be commited to your Version Control System. Eg. Github

### Terraform State Files

`.terraform.tfstate` contains information about the current state of infrastructure.

This file **should not be commited** to VCS.

This file can contain sensitive data.
If you lose this file, you lose knowing the state of infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

### Terraform Directory

`.terraform/` contains the required binaries. 

## Issues with Terraform Cloud and Gitpod Workspace

When attempting to run `terraform login`, it will launch in bash a wisiwig view to generate a token. It may not work as expected in Gitpod VSCode in the browser.

The workaround is to manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create and open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json 
open /home/gitpod/.terraform.d/credentials.tfrc.json 
```

Provide the following code (replace the code in the file)

```json
{
    credentials: {
        "app.terraform.io":{
            "token":"TERRAFORM-TOKEN"
        }
    }
}
```

We have automated the terraform login process using the bash script:
[bin/generate_tfrc_credentials.sh](bin/generate_tfrc_credentials.sh)

## Serving up a static page
1. Create an S3 bucket with default settings.
2. Enable static website hosting in the properties tab.
3. Create a `public/index.html`
4. run `npm install http-server -g` to install http-server globally.
5. Then run `http-server`

### Upload a local file to an AWS S3 bucket

`aws s3 cp test.txt s3://mybucket/test2.txt`

You will then see an output like this:

```bash
Completed 17 Bytes/17 Bytes (40 Bytes/s) with 1 file(s) rupload: public/index.html to s3://bucket-name/index.html
```

### Accessing statically-hosted webpage

There will be a link to the page created by S3, under `properties`.

However, there will be a 403 error when accessing this page. This is because, by default, the `permissions` block public access. 

While it is possible to create a bucket policy to allow public access, this is not the recommended method.

The recommended method, is to create a `CloudFront Distribution`. This is a CDN which creates a copy of our website, and caches it to a bunch of computers around the world. Then it serves the webpage (which is really the `index.html` file), from a computer which is near to the computer that accessed it. 

Even after creating the CDN, opening the link created by the CDN will lead to a 403 Forbidden error.

That is because, an OAC (Origin Access Control) and Bucket Policy need to be created.

To create an OAC, go to CloudFront, and open up Security/Origin Access on the left side menu. Here, a new OAC can be created. 


https://developer.hashicorp.com/terraform/language/modules/develop/structure

