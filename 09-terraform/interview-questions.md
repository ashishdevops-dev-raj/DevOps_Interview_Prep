# Terraform Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Terraform?
Terraform is an Infrastructure as Code (IaC) tool that allows you to define and provision infrastructure using declarative configuration files.

### 2. What is Infrastructure as Code (IaC)?
IaC is the practice of managing and provisioning infrastructure through machine-readable definition files rather than manual processes.

### 3. What is HashiCorp Configuration Language (HCL)?
HCL is the configuration language used by Terraform. It's designed to be human-readable and machine-friendly.

### 4. What are the main components of Terraform?
- Configuration files (.tf files)
- State file (.tfstate)
- Providers
- Resources
- Variables
- Outputs

### 5. What is a Terraform provider?
A provider is a plugin that Terraform uses to interact with APIs of cloud providers or services (AWS, Azure, GCP, etc.).

### 6. How do you initialize Terraform?
```bash
terraform init
```

### 7. What does `terraform init` do?
- Downloads required providers
- Initializes backend
- Sets up working directory

### 8. What is `terraform plan`?
`terraform plan` creates an execution plan showing what Terraform will do when you apply the configuration.

### 9. What is `terraform apply`?
`terraform apply` executes the plan and creates/updates/destroys resources as defined.

### 10. What is `terraform destroy`?
`terraform destroy` removes all resources defined in the configuration.

### 11. What is a Terraform resource?
A resource is a component of your infrastructure (e.g., EC2 instance, S3 bucket, VPC).

### 12. How do you define a resource?
```hcl
resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t3.micro"
}
```

### 13. What is a Terraform variable?
A variable allows you to parameterize your configuration, making it reusable and flexible.

### 14. How do you define a variable?
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
```

### 15. How do you use a variable?
```hcl
resource "aws_instance" "example" {
  instance_type = var.instance_type
}
```

### 16. What is a Terraform output?
An output exposes information about your infrastructure after it's created.

### 17. How do you define an output?
```hcl
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

### 18. What is a data source?
A data source allows you to fetch information from existing resources or external systems.

### 19. How do you use a data source?
```hcl
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]
}
```

### 20. What is the Terraform state file?
The state file tracks the mapping between your configuration and real-world resources.

### 21. Why is the state file important?
- Tracks resource relationships
- Enables Terraform to update/destroy resources
- Stores resource metadata

### 22. What is a backend?
A backend determines where Terraform stores its state file (local, S3, Azure Storage, etc.).

### 23. What is a local backend?
Local backend stores state file on the local filesystem (default).

### 24. What is a remote backend?
Remote backend stores state file in a remote location (S3, Azure Storage, GCS, Terraform Cloud).

### 25. What is state locking?
State locking prevents multiple users from modifying the same state simultaneously.

### 26. What is `terraform fmt`?
`terraform fmt` formats Terraform configuration files to a canonical format.

### 27. What is `terraform validate`?
`terraform validate` checks if the configuration is syntactically valid and internally consistent.

### 28. What is `terraform show`?
`terraform show` displays the current state or a saved plan.

### 29. What is `terraform output`?
`terraform output` displays the values of output variables.

### 30. What is a Terraform workspace?
A workspace allows you to manage multiple environments (dev, staging, prod) with the same configuration.

### 31. How do you create a workspace?
```bash
terraform workspace new dev
```

### 32. How do you switch workspaces?
```bash
terraform workspace select dev
```

### 33. What is `terraform.tfvars`?
`terraform.tfvars` is a file where you can assign values to variables.

### 34. What is `.terraformignore`?
`.terraformignore` specifies files that Terraform should ignore (similar to `.gitignore`).

### 35. What is the difference between `terraform plan` and `terraform apply`?
- `terraform plan`: Shows what will happen (dry run)
- `terraform apply`: Actually makes the changes

## Medium Level (Questions 36-70)

### 36. What is a Terraform module?
A module is a container for multiple resources that are used together, promoting reusability.

### 37. How do you use a module?
```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr   = "10.0.0.0/16"
}
```

### 38. What is a root module?
The root module is the directory where you run `terraform` commands, containing your main configuration.

### 39. What is a child module?
A child module is called from another module using the `module` block.

### 40. What is the Terraform Registry?
The Terraform Registry is a public repository of modules and providers.

### 41. How do you use a module from the registry?
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"
}
```

### 42. What is `terraform import`?
`terraform import` brings existing infrastructure under Terraform management.

### 43. How do you import a resource?
```bash
terraform import aws_instance.example i-1234567890abcdef0
```

### 44. What is `terraform taint`?
`terraform taint` marks a resource for recreation on the next apply (deprecated, use `terraform apply -replace`).

### 45. What is `terraform untaint`?
`terraform untaint` removes the taint from a resource (deprecated).

### 46. What is `terraform state list`?
`terraform state list` lists all resources in the state.

### 47. What is `terraform state show`?
`terraform state show` shows the attributes of a resource in the state.

### 48. What is `terraform state mv`?
`terraform state mv` moves a resource in the state (useful for refactoring).

### 49. What is `terraform state rm`?
`terraform state rm` removes a resource from the state without destroying it.

### 50. What is a provisioner?
A provisioner allows you to execute scripts on local or remote machines after resource creation.

### 51. What are the types of provisioners?
- **local-exec**: Runs commands on the machine running Terraform
- **remote-exec**: Runs commands on the created resource
- **file**: Copies files to the created resource

### 52. What is a null_resource?
A null_resource is a resource that doesn't create anything but can trigger provisioners.

### 53. What is `depends_on`?
`depends_on` explicitly defines resource dependencies.

### 54. How do you use `depends_on`?
```hcl
resource "aws_instance" "example" {
  depends_on = [aws_security_group.example]
}
```

### 55. What is `count`?
`count` creates multiple instances of a resource.

### 56. How do you use `count`?
```hcl
resource "aws_instance" "example" {
  count = 3
  # ...
}
```

### 57. What is `for_each`?
`for_each` creates multiple instances of a resource based on a map or set.

### 58. How do you use `for_each`?
```hcl
resource "aws_instance" "example" {
  for_each = {
    web1 = "t3.micro"
    web2 = "t3.small"
  }
  instance_type = each.value
}
```

### 59. What is the difference between `count` and `for_each`?
- `count`: Creates resources with numeric indices
- `for_each`: Creates resources with string keys (better for refactoring)

### 60. What is `terraform graph`?
`terraform graph` generates a visual representation of the dependency graph.

### 61. What is a lifecycle block?
A lifecycle block allows you to control resource lifecycle behavior.

### 62. What are lifecycle options?
- `create_before_destroy`: Create new before destroying old
- `prevent_destroy`: Prevent resource destruction
- `ignore_changes`: Ignore changes to specific attributes

### 63. What is `terraform console`?
`terraform console` provides an interactive console for testing expressions.

### 64. What is a local value?
A local value assigns a name to an expression, making configuration more readable.

### 65. How do you define a local value?
```hcl
locals {
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}
```

### 66. What is `terraform workspace show`?
`terraform workspace show` displays the current workspace name.

### 67. What is `terraform workspace list`?
`terraform workspace list` lists all workspaces.

### 68. What is variable validation?
Variable validation allows you to add custom validation rules to variables.

### 69. How do you add variable validation?
```hcl
variable "instance_count" {
  type = number
  validation {
    condition     = var.instance_count > 0
    error_message = "Instance count must be positive."
  }
}
```

### 70. What is `sensitive` variable?
A `sensitive` variable prevents its value from being displayed in logs and output.

## High/Advanced Level (Questions 71-100)

### 71. What is Terraform Cloud?
Terraform Cloud is a hosted service for Terraform that provides remote state, collaboration, and automation.

### 72. What is Terraform Enterprise?
Terraform Enterprise is the self-hosted version of Terraform Cloud.

### 73. What is a remote state data source?
A remote state data source allows you to use outputs from another Terraform configuration.

### 74. How do you use remote state?
```hcl
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "vpc/terraform.tfstate"
  }
}
```

### 75. What is `terraform force-unlock`?
`terraform force-unlock` manually releases a lock on the state.

### 76. What is a backend configuration?
Backend configuration determines where and how Terraform stores state.

### 77. What is partial backend configuration?
Partial backend configuration allows you to provide some backend settings via command line.

### 78. What is `terraform refresh`?
`terraform refresh` updates the state file to match the real-world infrastructure (now automatic in plan/apply).

### 79. What is a provider alias?
A provider alias allows you to use multiple provider configurations.

### 80. How do you use provider alias?
```hcl
provider "aws" {
  alias  = "us-west"
  region = "us-west-2"
}

resource "aws_instance" "example" {
  provider = aws.us-west
  # ...
}
```

### 81. What is `terraform version`?
`terraform version` displays Terraform version and provider versions.

### 82. What is provider version constraints?
Provider version constraints specify which provider versions are acceptable.

### 83. How do you specify provider versions?
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
```

### 84. What is `terraform providers lock`?
`terraform providers lock` writes dependency lock information to `.terraform.lock.hcl`.

### 85. What is a custom provider?
A custom provider is a provider developed for a specific service or API.

### 86. What is `terraform fmt -recursive`?
`terraform fmt -recursive` formats all Terraform files in subdirectories.

### 87. What is `terraform fmt -check`?
`terraform fmt -check` checks if files are formatted without modifying them.

### 88. What is `terraform plan -out`?
`terraform plan -out` saves the plan to a file for later application.

### 89. What is `terraform apply -target`?
`terraform apply -target` applies changes only to specific resources.

### 90. What is `terraform apply -replace`?
`terraform apply -replace` forces replacement of a specific resource.

### 91. What is `terraform state pull`?
`terraform state pull` downloads the current state and outputs it to stdout.

### 92. What is `terraform state push`?
`terraform state push` uploads a local state file to the backend.

### 93. What is `terraform validate -json`?
`terraform validate -json` outputs validation results in JSON format.

### 94. What is a Terraform function?
A Terraform function performs computations and transformations (e.g., `length()`, `merge()`, `cidrsubnet()`).

### 95. What are common Terraform functions?
- String: `join()`, `split()`, `replace()`
- Numeric: `max()`, `min()`, `abs()`
- Collection: `length()`, `keys()`, `values()`
- Encoding: `base64encode()`, `jsonencode()`

### 96. What is `terraform workspace delete`?
`terraform workspace delete` deletes a workspace (must be empty).

### 97. What is a conditional expression?
A conditional expression allows you to choose between two values based on a condition.

### 98. How do you use conditional expressions?
```hcl
resource "aws_instance" "example" {
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
}
```

### 99. What is `terraform plan -destroy`?
`terraform plan -destroy` creates a plan to destroy all resources.

### 100. What are Terraform best practices?
- Use version control for all Terraform files
- Use remote backend for state
- Enable state locking
- Use modules for reusability
- Use variables for flexibility
- Use workspaces for environments
- Never commit state files
- Use `.terraformignore`
- Validate and format before committing
- Use provider version constraints
- Document your code
- Use meaningful resource names
- Implement proper error handling
- Use `terraform plan` before `apply`
- Regular state backups

