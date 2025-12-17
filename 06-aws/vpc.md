# AWS VPC (Virtual Private Cloud)

## Overview
Amazon VPC enables you to provision a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define.

## Key Concepts

### VPC Components
- **VPC**: Virtual network in AWS
- **Subnet**: Range of IP addresses in VPC
- **Route Table**: Rules for network traffic
- **Internet Gateway**: Allows internet access
- **NAT Gateway**: Allows outbound internet for private subnets
- **Security Groups**: Stateful firewall at instance level
- **NACLs**: Stateless firewall at subnet level
- **VPC Peering**: Connect two VPCs
- **VPN**: Connect VPC to on-premises

### IP Addressing
- **CIDR Block**: Defines IP address range (e.g., 10.0.0.0/16)
- **Public Subnet**: Has route to Internet Gateway
- **Private Subnet**: No direct internet access
- **Elastic IP**: Static public IP address

## Common Operations

### VPC
```bash
# Create VPC
aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'

# Describe VPCs
aws ec2 describe-vpcs

# Delete VPC
aws ec2 delete-vpc --vpc-id vpc-12345678
```

### Subnets
```bash
# Create subnet
aws ec2 create-subnet \
    --vpc-id vpc-12345678 \
    --cidr-block 10.0.1.0/24 \
    --availability-zone us-east-1a

# Create public subnet
aws ec2 create-subnet \
    --vpc-id vpc-12345678 \
    --cidr-block 10.0.1.0/24 \
    --availability-zone us-east-1a \
    --map-public-ip-on-launch

# List subnets
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-12345678"

# Delete subnet
aws ec2 delete-subnet --subnet-id subnet-12345678
```

### Internet Gateway
```bash
# Create Internet Gateway
aws ec2 create-internet-gateway

# Attach to VPC
aws ec2 attach-internet-gateway \
    --internet-gateway-id igw-12345678 \
    --vpc-id vpc-12345678

# Detach Internet Gateway
aws ec2 detach-internet-gateway \
    --internet-gateway-id igw-12345678 \
    --vpc-id vpc-12345678

# Delete Internet Gateway
aws ec2 delete-internet-gateway --internet-gateway-id igw-12345678
```

### Route Tables
```bash
# Create route table
aws ec2 create-route-table --vpc-id vpc-12345678

# Add route to Internet Gateway
aws ec2 create-route \
    --route-table-id rtb-12345678 \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id igw-12345678

# Associate subnet with route table
aws ec2 associate-route-table \
    --subnet-id subnet-12345678 \
    --route-table-id rtb-12345678

# List route tables
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=vpc-12345678"
```

### NAT Gateway
```bash
# Allocate Elastic IP
aws ec2 allocate-address --domain vpc

# Create NAT Gateway
aws ec2 create-nat-gateway \
    --subnet-id subnet-12345678 \
    --allocation-id eipalloc-12345678

# Add route to NAT Gateway
aws ec2 create-route \
    --route-table-id rtb-12345678 \
    --destination-cidr-block 0.0.0.0/0 \
    --nat-gateway-id nat-12345678
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

# Add outbound rule
aws ec2 authorize-security-group-egress \
    --group-id sg-12345678 \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0
```

### Network ACLs
```bash
# Create Network ACL
aws ec2 create-network-acl --vpc-id vpc-12345678

# Create Network ACL entry
aws ec2 create-network-acl-entry \
    --network-acl-id acl-12345678 \
    --rule-number 100 \
    --protocol tcp \
    --port-range From=22,To=22 \
    --cidr-block 0.0.0.0/0 \
    --egress \
    --rule-action allow
```

### VPC Peering
```bash
# Create peering connection
aws ec2 create-vpc-peering-connection \
    --vpc-id vpc-12345678 \
    --peer-vpc-id vpc-87654321

# Accept peering connection
aws ec2 accept-vpc-peering-connection \
    --vpc-peering-connection-id pcx-12345678

# Add route for peering
aws ec2 create-route \
    --route-table-id rtb-12345678 \
    --destination-cidr-block 10.1.0.0/16 \
    --vpc-peering-connection-id pcx-12345678
```

## Common Architectures

### Public/Private Subnet Architecture
```
VPC (10.0.0.0/16)
├── Public Subnet (10.0.1.0/24)
│   ├── Internet Gateway
│   └── EC2 Instances (Web Servers)
└── Private Subnet (10.0.2.0/24)
    ├── NAT Gateway
    └── EC2 Instances (Application/DB)
```

### Multi-AZ Architecture
```
VPC (10.0.0.0/16)
├── AZ-1a
│   ├── Public Subnet (10.0.1.0/24)
│   └── Private Subnet (10.0.2.0/24)
└── AZ-1b
    ├── Public Subnet (10.0.3.0/24)
    └── Private Subnet (10.0.4.0/24)
```

## Best Practices

1. **CIDR Planning**: Plan IP address ranges carefully
2. **Multi-AZ**: Deploy across multiple availability zones
3. **Public/Private Separation**: Use public subnets for load balancers, private for application/DB
4. **NAT Gateway**: Use NAT Gateway for outbound internet from private subnets
5. **Security Groups**: Use security groups (stateful) as primary defense
6. **NACLs**: Use NACLs for subnet-level rules (stateless)
7. **VPC Flow Logs**: Enable for network monitoring
8. **Route Tables**: Keep route tables simple and organized
9. **Tagging**: Tag all VPC resources for management
10. **IP Address Conservation**: Use appropriate CIDR block sizes

## Security

### Security Groups vs NACLs
- **Security Groups**: Stateful, instance-level, default deny
- **NACLs**: Stateless, subnet-level, explicit allow/deny

### VPC Flow Logs
```bash
# Create flow log
aws ec2 create-flow-logs \
    --resource-type VPC \
    --resource-ids vpc-12345678 \
    --traffic-type ALL \
    --log-destination-type cloud-watch-logs \
    --log-group-name VPCFlowLogs
```

## Common Use Cases

- Isolated network environments
- Multi-tier applications
- Hybrid cloud connectivity
- Compliance requirements
- Network segmentation
- Disaster recovery

