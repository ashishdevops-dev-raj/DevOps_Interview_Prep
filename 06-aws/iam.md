# AWS IAM (Identity and Access Management)

## Overview
IAM enables you to manage access to AWS services and resources securely. It controls who (authentication) and what (authorization) can access AWS resources.

## Key Concepts

### Users
Individual accounts that can interact with AWS services. Can have:
- Access keys (for programmatic access)
- Console password (for AWS Management Console)
- Permissions via policies

### Groups
Collections of users. Permissions assigned to a group apply to all users in that group.

### Roles
Temporary credentials that can be assumed by users, services, or applications. More secure than access keys.

### Policies
Documents that define permissions. Can be:
- **Managed Policies**: AWS-managed or customer-managed
- **Inline Policies**: Embedded directly in user/group/role

### Policy Structure
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
```

## Common Operations

### Users
```bash
# Create user
aws iam create-user --user-name myuser

# List users
aws iam list-users

# Get user details
aws iam get-user --user-name myuser

# Create access key
aws iam create-access-key --user-name myuser

# Create login profile (console access)
aws iam create-login-profile \
    --user-name myuser \
    --password MyPassword123! \
    --password-reset-required

# Delete user
aws iam delete-user --user-name myuser
```

### Groups
```bash
# Create group
aws iam create-group --group-name Developers

# List groups
aws iam list-groups

# Add user to group
aws iam add-user-to-group \
    --user-name myuser \
    --group-name Developers

# Remove user from group
aws iam remove-user-from-group \
    --user-name myuser \
    --group-name Developers

# Attach policy to group
aws iam attach-group-policy \
    --group-name Developers \
    --policy-arn arn:aws:iam::aws:policy/PowerUserAccess
```

### Roles
```bash
# Create role
aws iam create-role \
    --role-name MyRole \
    --assume-role-policy-document file://trust-policy.json

# Attach policy to role
aws iam attach-role-policy \
    --role-name MyRole \
    --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

# Assume role
aws sts assume-role \
    --role-arn arn:aws:iam::123456789012:role/MyRole \
    --role-session-name mysession

# List roles
aws iam list-roles
```

### Policies
```bash
# Create policy
aws iam create-policy \
    --policy-name MyPolicy \
    --policy-document file://policy.json

# Attach policy to user
aws iam attach-user-policy \
    --user-name myuser \
    --policy-arn arn:aws:iam::123456789012:policy/MyPolicy

# List policies
aws iam list-policies

# Get policy
aws iam get-policy --policy-arn arn:aws:iam::123456789012:policy/MyPolicy

# Delete policy
aws iam delete-policy --policy-arn arn:aws:iam::123456789012:policy/MyPolicy
```

## Policy Examples

### S3 Read-Only Access
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::my-bucket",
        "arn:aws:s3:::my-bucket/*"
      ]
    }
  ]
}
```

### EC2 Full Access
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:*",
      "Resource": "*"
    }
  ]
}
```

### Assume Role Policy (Trust Policy)
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

## Best Practices

1. **Least Privilege**: Grant minimum permissions needed
2. **Use Roles**: Prefer roles over access keys for EC2/Lambda
3. **MFA**: Enable Multi-Factor Authentication for sensitive operations
4. **Regular Audits**: Review and remove unused permissions
5. **Groups**: Use groups instead of attaching policies to users
6. **Policy Conditions**: Use conditions for additional security
7. **Separate Accounts**: Use separate accounts for different environments
8. **Access Keys Rotation**: Rotate access keys regularly
9. **IAM Roles for Services**: Use service roles for AWS services
10. **CloudTrail**: Enable CloudTrail for IAM API logging

## Security Features

### MFA (Multi-Factor Authentication)
```bash
# Enable MFA for user
aws iam enable-mfa-device \
    --user-name myuser \
    --serial-number arn:aws:iam::123456789012:mfa/myuser \
    --authentication-code-1 123456 \
    --authentication-code-2 654321
```

### Password Policy
```bash
aws iam update-account-password-policy \
    --minimum-password-length 12 \
    --require-symbols \
    --require-numbers \
    --require-uppercase-characters \
    --require-lowercase-characters \
    --allow-users-to-change-password \
    --max-password-age 90 \
    --password-reuse-prevention 5
```

### Access Analyzer
Helps identify resources shared with external entities.

## Common Use Cases

- Service roles for EC2 instances
- Cross-account access
- Federated access (SAML, OIDC)
- Programmatic access for applications
- Temporary access for third parties

