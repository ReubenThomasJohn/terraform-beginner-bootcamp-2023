# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage: :mage:

This project will utilize semantic versioning for its tagging.

Refer: [semver.org](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH**, increment the:

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

---

## General workflow:

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
