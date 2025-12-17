# AWS EC2 (Elastic Compute Cloud)

## Overview
Amazon EC2 provides resizable compute capacity in the cloud. It allows you to launch virtual servers (instances) with various configurations.

## Key Concepts

### Instance Types
- **General Purpose**: Balanced compute, memory, and networking (t3, m5)
- **Compute Optimized**: High-performance processors (c5, c6g)
- **Memory Optimized**: Large memory for databases (r5, x1)
- **Storage Optimized**: High I/O for databases (i3, d2)
- **Accelerated Computing**: GPUs for machine learning (p3, g4)

### Instance Lifecycle
1. **Launch**: Start instance
2. **Running**: Instance is active
3. **Stopped**: Instance is stopped (not terminated)
4. **Terminated**: Instance is deleted

### Pricing Models
- **On-Demand**: Pay per hour, no commitment
- **Reserved Instances**: 1-3 year commitment, up to 75% discount
- **Spot Instances**: Bid on unused capacity, up to 90% discount
- **Dedicated Hosts**: Physical server dedicated to your use

## Common Operations

### Launch Instance
```bash
aws ec2 run-instances \
    --image-id ami-0c55b159cbfafe1f0 \
    --instance-type t2.micro \
    --key-name my-key \
    --security-group-ids sg-12345678 \
    --subnet-id subnet-12345678 \
    --user-data file://user-data.sh
```

### Instance Management
```bash
# Start instance
aws ec2 start-instances --instance-ids i-1234567890abcdef0

# Stop instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Reboot instance
aws ec2 reboot-instances --instance-ids i-1234567890abcdef0

# Terminate instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0

# Describe instances
aws ec2 describe-instances
aws ec2 describe-instances --instance-ids i-1234567890abcdef0
```

### Key Pairs
```bash
# Create key pair
aws ec2 create-key-pair --key-name my-key --query 'KeyMaterial' --output text > my-key.pem

# List key pairs
aws ec2 describe-key-pairs

# Delete key pair
aws ec2 delete-key-pair --key-name my-key
```

### Security Groups
```bash
# Create security group
aws ec2 create-security-group \
    --group-name my-sg \
    --description "My security group" \
    --vpc-id vpc-12345678

# Add inbound rule
aws ec2 authorize-security-group-ingress \
    --group-id sg-12345678 \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

# Describe security groups
aws ec2 describe-security-groups
```

### Elastic IPs
```bash
# Allocate Elastic IP
aws ec2 allocate-address

# Associate with instance
aws ec2 associate-address \
    --instance-id i-1234567890abcdef0 \
    --allocation-id eipalloc-12345678

# Release Elastic IP
aws ec2 release-address --allocation-id eipalloc-12345678
```

### AMIs (Amazon Machine Images)
```bash
# Create AMI from instance
aws ec2 create-image \
    --instance-id i-1234567890abcdef0 \
    --name "my-ami" \
    --description "My custom AMI"

# Describe AMIs
aws ec2 describe-images --owners self

# Deregister AMI
aws ec2 deregister-image --image-id ami-12345678
```

### Snapshots
```bash
# Create snapshot
aws ec2 create-snapshot \
    --volume-id vol-1234567890abcdef0 \
    --description "My snapshot"

# Describe snapshots
aws ec2 describe-snapshots --owner-ids self

# Delete snapshot
aws ec2 delete-snapshot --snapshot-id snap-12345678
```

### EBS Volumes
```bash
# Create volume
aws ec2 create-volume \
    --availability-zone us-east-1a \
    --size 100 \
    --volume-type gp3

# Attach volume
aws ec2 attach-volume \
    --volume-id vol-1234567890abcdef0 \
    --instance-id i-1234567890abcdef0 \
    --device /dev/sdf

# Detach volume
aws ec2 detach-volume --volume-id vol-1234567890abcdef0
```

## Auto Scaling

### Launch Template
```bash
aws ec2 create-launch-template \
    --launch-template-name my-template \
    --launch-template-data file://template-data.json
```

### Auto Scaling Group
```bash
aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name my-asg \
    --launch-template LaunchTemplateName=my-template \
    --min-size 1 \
    --max-size 10 \
    --desired-capacity 3 \
    --vpc-zone-identifier "subnet-12345678,subnet-87654321"
```

## Best Practices

1. **Use IAM Roles**: Don't store credentials on instances
2. **Security Groups**: Follow least privilege principle
3. **Multi-AZ**: Deploy across availability zones
4. **Auto Scaling**: Use for variable workloads
5. **Reserved Instances**: For predictable workloads
6. **Monitoring**: Enable CloudWatch monitoring
7. **Backup**: Regular snapshots and AMIs
8. **Tagging**: Use tags for resource management
9. **User Data**: Automate instance configuration
10. **Elastic IPs**: Use for static IP requirements

## Common Use Cases

- Web servers
- Application servers
- Database servers
- Development/testing environments
- Batch processing
- High-performance computing

