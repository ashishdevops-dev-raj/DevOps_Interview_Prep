# AWS Interview Questions

## Easy Level (Questions 1-35)

### 1. What is AWS?
Amazon Web Services (AWS) is a cloud computing platform providing on-demand computing resources and services.

### 2. What is EC2?
Amazon EC2 provides resizable compute capacity in the cloud. It allows launching virtual servers with various configurations.

### 3. What are the EC2 instance types?
- **General Purpose**: Balanced (t3, m5)
- **Compute Optimized**: High CPU (c5, c6g)
- **Memory Optimized**: High RAM (r5, x1)
- **Storage Optimized**: High I/O (i3, d2)
- **Accelerated Computing**: GPUs (p3, g4)

### 4. What is the difference between stopping and terminating an instance?
- **Stopping**: Instance is stopped, data on EBS volumes is preserved, can be restarted
- **Terminating**: Instance is deleted, root EBS volume is deleted (unless configured otherwise)

### 5. What is an AMI?
AMI (Amazon Machine Image) is a template for creating EC2 instances. Contains OS, application server, and applications.

### 6. What is the difference between EBS and Instance Store?
- **EBS**: Persistent storage, survives instance stop/terminate, can be detached/attached
- **Instance Store**: Ephemeral storage, lost on instance stop/terminate, better performance

### 7. What are the EC2 pricing models?
- **On-Demand**: Pay per hour, no commitment
- **Reserved Instances**: 1-3 year commitment, up to 75% discount
- **Spot Instances**: Bid on unused capacity, up to 90% discount
- **Dedicated Hosts**: Physical server dedicated to your use

### 8. What is Auto Scaling?
Auto Scaling automatically adjusts the number of EC2 instances based on demand, ensuring optimal performance and cost.

### 9. What is Elastic IP?
Elastic IP is a static, public IPv4 address that you can allocate and associate with EC2 instances.

### 10. What is IAM?
IAM enables you to manage access to AWS services and resources securely. Controls authentication and authorization.

### 11. What is the difference between IAM User and IAM Role?
- **User**: Permanent identity with long-term credentials
- **Role**: Temporary identity assumed by users, services, or applications

### 12. What is the principle of least privilege?
Grant users and roles only the minimum permissions needed to perform their tasks.

### 13. What is an IAM Policy?
An IAM Policy is a document that defines permissions. Can be attached to users, groups, or roles.

### 14. What is the difference between managed and inline policies?
- **Managed Policy**: Reusable policy that can be attached to multiple entities
- **Inline Policy**: Embedded directly in a user, group, or role

### 15. What is MFA?
MFA (Multi-Factor Authentication) adds an extra layer of security by requiring additional authentication beyond username/password.

### 16. What is IAM Role for EC2?
IAM Role for EC2 allows EC2 instances to access AWS services without storing credentials. More secure than access keys.

### 17. What is a VPC?
VPC is a logically isolated section of AWS Cloud where you can launch resources in a virtual network.

### 18. What is the difference between public and private subnet?
- **Public Subnet**: Has route to Internet Gateway, resources can have public IPs
- **Private Subnet**: No direct internet access, uses NAT Gateway for outbound

### 19. What is an Internet Gateway?
Internet Gateway allows communication between resources in VPC and the internet. Attached to VPC.

### 20. What is a NAT Gateway?
NAT Gateway allows resources in private subnets to access the internet for outbound traffic while preventing inbound access.

### 21. What is the difference between Security Group and NACL?
- **Security Group**: Stateful, instance-level, default deny, rules are evaluated together
- **NACL**: Stateless, subnet-level, explicit allow/deny, rules evaluated in order

### 22. What is S3?
S3 is object storage service for storing and retrieving any amount of data from anywhere.

### 23. What are S3 storage classes?
- **Standard**: General purpose, frequently accessed
- **IA (Infrequent Access)**: Less frequently accessed
- **Glacier**: Archive storage
- **Intelligent-Tiering**: Automatically moves objects between tiers

### 24. What is S3 versioning?
S3 versioning keeps multiple versions of an object, protecting against accidental deletion or overwrites.

### 25. What is S3 lifecycle policy?
Lifecycle policies automate moving objects between storage classes or deleting them based on rules.

### 26. What is the difference between S3 and EBS?
- **S3**: Object storage, unlimited capacity, accessed via API
- **EBS**: Block storage, attached to EC2 instances, limited capacity

### 27. What is CloudWatch?
CloudWatch is a monitoring and observability service for AWS resources and applications.

### 28. What is Lambda?
Lambda is a serverless compute service that runs code in response to events without provisioning servers.

### 29. What is RDS?
RDS (Relational Database Service) is a managed database service supporting MySQL, PostgreSQL, Oracle, SQL Server, etc.

### 30. What is Route 53?
Route 53 is a scalable DNS web service for domain registration and DNS routing.

### 31. What is CloudFront?
CloudFront is a content delivery network (CDN) that delivers data, videos, applications, and APIs globally.

### 32. What is ELB?
ELB (Elastic Load Balancer) distributes incoming traffic across multiple targets (EC2, containers, IPs).

### 33. What are the types of Load Balancers?
- **Application Load Balancer (ALB)**: Layer 7, HTTP/HTTPS
- **Network Load Balancer (NLB)**: Layer 4, TCP/UDP
- **Classic Load Balancer**: Legacy, Layer 4/7

### 34. What is SNS?
SNS (Simple Notification Service) is a messaging service for sending notifications to subscribers.

### 35. What is SQS?
SQS (Simple Queue Service) is a message queuing service for decoupling and scaling microservices.

## Medium Level (Questions 36-70)

### 36. What is CloudFormation?
CloudFormation is Infrastructure as Code service that allows you to model and provision AWS resources using templates.

### 37. What is ECS?
ECS (Elastic Container Service) is a container orchestration service for running Docker containers.

### 38. What is EKS?
EKS (Elastic Kubernetes Service) is a managed Kubernetes service for running containerized applications.

### 39. What is VPC Peering?
VPC Peering connects two VPCs, allowing resources to communicate using private IP addresses.

### 40. What is a Route Table?
Route Table contains rules (routes) that determine where network traffic is directed.

### 41. What is VPC Flow Logs?
VPC Flow Logs captures information about IP traffic going to and from network interfaces in VPC.

### 42. What is CloudTrail?
CloudTrail logs API calls and events for AWS accounts, providing audit trail.

### 43. What is AWS Config?
Config monitors and records configuration changes to AWS resources.

### 44. What is AWS Secrets Manager?
Secrets Manager helps protect secrets needed to access applications, services, and IT resources.

### 45. What is the Shared Responsibility Model?
AWS is responsible for security OF the cloud (infrastructure), customer is responsible for security IN the cloud (data, applications).

### 46. What is AWS WAF?
WAF (Web Application Firewall) protects web applications from common web exploits.

### 47. What is AWS Shield?
Shield provides DDoS protection for AWS resources.

### 48. What is the Well-Architected Framework?
Framework with five pillars: Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization.

### 49. What is AWS Organizations?
Organizations helps manage multiple AWS accounts centrally.

### 50. How do you secure data in transit and at rest?
- **In Transit**: Use TLS/SSL, VPN, encrypted connections
- **At Rest**: Use encryption (KMS, S3 encryption, EBS encryption)

### 51. What is KMS?
KMS (Key Management Service) creates and manages encryption keys for encrypting data.

### 52. What is DynamoDB?
DynamoDB is a fully managed NoSQL database service providing fast and predictable performance.

### 53. What is ElastiCache?
ElastiCache is a fully managed in-memory caching service supporting Redis and Memcached.

### 54. What is EFS?
EFS (Elastic File System) is a fully managed NFS file system for EC2 instances.

### 55. What is CloudWatch Logs?
CloudWatch Logs monitors, stores, and accesses log files from AWS resources.

### 56. What is CloudWatch Alarms?
CloudWatch Alarms monitor metrics and trigger actions when thresholds are breached.

### 57. What is EventBridge?
EventBridge is a serverless event bus that connects applications using events.

### 58. What is Step Functions?
Step Functions coordinates multiple AWS services into serverless workflows.

### 59. What is API Gateway?
API Gateway creates, publishes, maintains, monitors, and secures REST and WebSocket APIs.

### 60. What is S3 Cross-Region Replication?
S3 Cross-Region Replication automatically replicates objects to another region for disaster recovery.

### 61. What is S3 Transfer Acceleration?
S3 Transfer Acceleration uses CloudFront edge locations to accelerate uploads to S3.

### 62. What is EBS Snapshot?
EBS Snapshot is a backup of an EBS volume stored in S3.

### 63. What is AMI Sharing?
AMI Sharing allows sharing custom AMIs with other AWS accounts.

### 64. What is Placement Groups?
Placement Groups influence the placement of instances for low latency or high throughput.

### 65. What is Enhanced Networking?
Enhanced Networking provides higher I/O performance and lower latency using SR-IOV.

### 66. What is Elastic Beanstalk?
Elastic Beanstalk is a platform-as-a-service for deploying and scaling web applications.

### 67. What is CodePipeline?
CodePipeline is a fully managed continuous delivery service for fast and reliable application updates.

### 68. What is CodeBuild?
CodeBuild is a fully managed build service that compiles source code, runs tests, and produces ready-to-deploy packages.

### 69. What is CodeDeploy?
CodeDeploy automates code deployments to EC2, Lambda, or on-premises instances.

### 70. What is Systems Manager?
Systems Manager provides operational insights and actions for AWS resources.

## High/Advanced Level (Questions 71-100)

### 71. What is VPC Endpoint?
VPC Endpoint allows private connectivity to AWS services without internet gateway or NAT.

### 72. What is Transit Gateway?
Transit Gateway simplifies network architecture by connecting VPCs and on-premises networks through a central hub.

### 73. What is Direct Connect?
Direct Connect establishes dedicated network connection from on-premises to AWS.

### 74. What is VPN?
VPN creates secure connection between on-premises network and VPC over the internet.

### 75. What is GuardDuty?
GuardDuty is a threat detection service that continuously monitors for malicious activity.

### 76. What is Inspector?
Inspector automatically assesses applications for vulnerabilities and deviations from best practices.

### 77. What is Macie?
Macie uses machine learning to discover, classify, and protect sensitive data in S3.

### 78. What is Certificate Manager?
Certificate Manager provisions, manages, and deploys SSL/TLS certificates.

### 79. What is CloudHSM?
CloudHSM provides dedicated hardware security modules (HSM) for cryptographic key storage.

### 80. What is IAM Access Analyzer?
Access Analyzer helps identify resources shared with external entities.

### 81. What is Resource Access Manager?
Resource Access Manager enables sharing AWS resources across accounts.

### 82. What is Control Tower?
Control Tower provides centralized governance and compliance across multiple AWS accounts.

### 83. What is Service Catalog?
Service Catalog allows organizations to create and manage catalogs of IT services.

### 84. What is Trusted Advisor?
Trusted Advisor provides real-time guidance to help provision resources following AWS best practices.

### 85. What is Cost Explorer?
Cost Explorer analyzes and visualizes AWS costs and usage over time.

### 86. What is Budgets?
Budgets set custom cost and usage budgets and receive alerts when thresholds are exceeded.

### 87. What is Reserved Instance Marketplace?
Reserved Instance Marketplace allows buying and selling unused Reserved Instances.

### 88. What is Savings Plans?
Savings Plans provide flexible pricing model offering lower prices in exchange for commitment to consistent usage.

### 89. What is Spot Fleet?
Spot Fleet manages a collection of Spot Instances and optionally On-Demand Instances.

### 90. What is EMR?
EMR (Elastic MapReduce) is a managed cluster platform for processing big data using Hadoop, Spark, etc.

### 91. What is Redshift?
Redshift is a fully managed data warehouse service for analytics.

### 92. What is Athena?
Athena is an interactive query service for analyzing data in S3 using SQL.

### 93. What is Glue?
Glue is a fully managed ETL service for preparing and transforming data for analytics.

### 94. What is Kinesis?
Kinesis is a platform for streaming data on AWS, enabling real-time analytics.

### 95. What is Data Pipeline?
Data Pipeline orchestrates data movement and transformation across AWS services.

### 96. What is AppSync?
AppSync creates serverless GraphQL and Pub/Sub APIs.

### 97. What is Cognito?
Cognito provides authentication, authorization, and user management for web and mobile apps.

### 98. What is IAM Identity Center?
IAM Identity Center (formerly SSO) provides single sign-on access to AWS accounts and applications.

### 99. What are AWS best practices?
- Use IAM roles instead of access keys
- Enable MFA for sensitive operations
- Use VPC for network isolation
- Enable CloudTrail for audit logging
- Use encryption at rest and in transit
- Implement least privilege access
- Use tags for resource management
- Enable versioning for S3
- Use multi-AZ for high availability
- Regular backups and disaster recovery

### 100. What is AWS Global Infrastructure?
AWS Global Infrastructure consists of:
- **Regions**: Geographic areas with multiple Availability Zones
- **Availability Zones**: Isolated locations within regions
- **Edge Locations**: Points of presence for CloudFront and Route 53
