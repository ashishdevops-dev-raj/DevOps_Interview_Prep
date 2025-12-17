# Terraform Commands Cheat Sheet

## Basic Commands

### Initialization
```bash
terraform init                    # Initialize Terraform working directory
terraform init -upgrade           # Upgrade provider plugins
terraform init -backend-config=config # Configure backend
terraform init -reconfigure      # Reconfigure backend
```

### Planning
```bash
terraform plan                    # Create execution plan
terraform plan -out=tfplan        # Save plan to file
terraform plan -var="key=value"   # Set variable
terraform plan -var-file=vars.tfvars  # Use variables file
terraform plan -destroy           # Plan for destruction
terraform plan -refresh=false     # Skip refresh
```

### Applying
```bash
terraform apply                   # Apply changes
terraform apply -auto-approve     # Skip confirmation
terraform apply tfplan            # Apply saved plan
terraform apply -target=resource  # Target specific resource
terraform apply -var="key=value"  # Set variable
```

### Destroying
```bash
terraform destroy                 # Destroy infrastructure
terraform destroy -auto-approve   # Skip confirmation
terraform destroy -target=resource # Target specific resource
```

### State Management
```bash
terraform state list              # List resources in state
terraform state show <resource>   # Show resource details
terraform state mv <src> <dst>    # Move resource in state
terraform state rm <resource>     # Remove resource from state
terraform state pull              # Pull state from backend
terraform state push              # Push state to backend
```

### Formatting and Validation
```bash
terraform fmt                      # Format Terraform files
terraform fmt -recursive          # Format all files recursively
terraform fmt -check              # Check if files are formatted
terraform validate                # Validate configuration
```

### Workspace Management
```bash
terraform workspace list          # List workspaces
terraform workspace show          # Show current workspace
terraform workspace new <name>    # Create new workspace
terraform workspace select <name> # Switch workspace
terraform workspace delete <name> # Delete workspace
```

### Output
```bash
terraform output                  # Show all outputs
terraform output <name>           # Show specific output
terraform output -json            # Output in JSON format
```

### Import
```bash
terraform import <resource> <id> # Import existing resource
```

### Graph
```bash
terraform graph                   # Generate dependency graph
terraform graph | dot -Tsvg > graph.svg  # Create visual graph
```

## Advanced Commands

### Providers
```bash
terraform providers               # Show provider requirements
terraform providers lock          # Lock provider versions
terraform providers mirror <path> # Mirror providers locally
```

### Console
```bash
terraform console                 # Interactive console
```

### Force Unlock
```bash
terraform force-unlock <lock-id>  # Force unlock state
```

### Taint/Untaint
```bash
terraform taint <resource>        # Mark resource for recreation
terraform untaint <resource>      # Remove taint
```

## Common Workflows

### Initial Setup
```bash
terraform init
terraform plan
terraform apply
```

### Update Infrastructure
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### Destroy Infrastructure
```bash
terraform plan -destroy
terraform destroy
```

### Import Existing Resources
```bash
terraform import aws_instance.example i-1234567890abcdef0
terraform plan  # Verify import
terraform apply
```

### Workspace Workflow
```bash
terraform workspace new dev
terraform workspace select dev
terraform apply
terraform workspace select prod
terraform apply
```

## State File Operations

### Backend Configuration
```bash
# In terraform block
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "path/to/state"
    region = "us-east-1"
  }
}
```

### Remote State
```bash
terraform init -backend-config="bucket=my-bucket"
```

## Debugging

### Logging
```bash
TF_LOG=DEBUG terraform apply       # Enable debug logging
TF_LOG=TRACE terraform apply       # Enable trace logging
TF_LOG_PATH=./terraform.log terraform apply  # Log to file
```

### Common Environment Variables
```bash
TF_LOG=DEBUG                       # Log level
TF_LOG_PATH=./terraform.log        # Log file path
TF_INPUT=0                         # Disable interactive input
TF_VAR_<name>=value                # Set variable
```

## Best Practices

### File Organization
```
.
├── main.tf           # Main configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── terraform.tfvars  # Variable values
├── providers.tf      # Provider configuration
└── modules/          # Reusable modules
```

### Version Constraints
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
```

### State Management
- Use remote backend (S3, Azure Storage, GCS)
- Enable state locking
- Use workspaces for environments
- Backup state files regularly

### Security
- Never commit state files
- Use `.gitignore` for sensitive files
- Use variables for secrets
- Consider using Vault for secrets

