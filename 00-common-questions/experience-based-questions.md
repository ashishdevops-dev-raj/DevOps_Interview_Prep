# Experience-Based Interview Questions

## 0-1 Year Experience (Entry Level)

### Fundamental Questions

#### 1. What is DevOps and why is it important?
DevOps combines development and operations to improve collaboration, automate processes, and deliver software faster and more reliably.

#### 2. Explain the basic DevOps workflow.
Code → Build → Test → Deploy → Monitor → Feedback

#### 3. What is Git and how do you use it?
Git is a version control system. Basic workflow: `git add`, `git commit`, `git push`, `git pull`.

#### 4. What is Docker and why use it?
Docker packages applications with dependencies, ensuring consistency across environments.

#### 5. What is a CI/CD pipeline?
A CI/CD pipeline automates building, testing, and deploying code.

#### 6. What is Linux and basic commands you know?
Linux is an open-source OS. Basic commands: `ls`, `cd`, `pwd`, `mkdir`, `rm`, `cp`, `mv`, `grep`, `find`.

#### 7. What is cloud computing?
Cloud computing delivers computing services over the internet (servers, storage, databases, etc.).

#### 8. What is AWS and what services do you know?
AWS is Amazon's cloud platform. Services: EC2, S3, VPC, IAM, RDS.

#### 9. What is monitoring and why is it important?
Monitoring tracks system health and performance to identify issues early.

#### 10. What is a script and why use it?
A script automates repetitive tasks, saving time and reducing errors.

## 1-2 Years Experience (Junior Level)

### Technical Depth Questions

#### 11. Explain how you would set up a CI/CD pipeline.
1. Configure Git repository
2. Set up Jenkins/GitLab CI
3. Create build stage
4. Add test stage
5. Configure deployment stage
6. Add notifications

#### 12. How do you containerize an application?
1. Create Dockerfile
2. Define base image
3. Install dependencies
4. Copy application code
5. Expose ports
6. Define startup command
7. Build and test image

#### 13. What is Kubernetes and how does it work?
Kubernetes orchestrates containers. Key components: Pods, Deployments, Services, Nodes.

#### 14. How do you manage infrastructure with Terraform?
1. Write Terraform configuration
2. Initialize with `terraform init`
3. Plan with `terraform plan`
4. Apply with `terraform apply`
5. Manage state

#### 15. How do you use Ansible for configuration management?
1. Create inventory file
2. Write playbooks
3. Define tasks
4. Run playbooks
5. Manage configurations

#### 16. Explain the difference between stateless and stateful applications.
- **Stateless**: No stored session data, can scale horizontally easily
- **Stateful**: Maintains session/state, requires careful scaling

#### 17. What is microservices architecture?
Microservices break applications into small, independent services that communicate via APIs.

#### 18. How do you handle secrets in DevOps?
Use secret management tools (Vault, AWS Secrets Manager, Kubernetes Secrets), never commit secrets to code.

#### 19. What is Infrastructure as Code and its benefits?
IaC manages infrastructure through code. Benefits: version control, consistency, repeatability, faster provisioning.

#### 20. How do you implement monitoring?
1. Choose monitoring tools (Prometheus, CloudWatch)
2. Instrument applications
3. Collect metrics
4. Create dashboards
5. Set up alerts

## 2-3 Years Experience (Mid-Level)

### Advanced Technical Questions

#### 21. Explain blue-green deployment strategy.
Maintain two identical production environments. Deploy to inactive environment, test, then switch traffic.

#### 22. How do you implement auto-scaling?
Configure auto-scaling based on metrics (CPU, memory, request count) to automatically add/remove resources.

#### 23. What is service mesh and when would you use it?
Service mesh manages service-to-service communication in microservices. Use for complex microservices architectures.

#### 24. How do you implement disaster recovery?
1. Define RTO and RPO
2. Set up backups
3. Implement replication
4. Create recovery procedures
5. Test regularly

#### 25. Explain GitOps workflow.
Use Git as single source of truth. Changes to Git trigger automated deployments to match Git state.

#### 26. How do you optimize Docker images?
- Use multi-stage builds
- Use minimal base images (Alpine)
- Combine RUN commands
- Use .dockerignore
- Remove unnecessary files

#### 27. How do you secure a Kubernetes cluster?
- Use RBAC
- Enable network policies
- Scan images for vulnerabilities
- Use secrets management
- Enable audit logging
- Keep cluster updated

#### 28. How do you implement observability?
Combine logs, metrics, and traces to understand system behavior and troubleshoot issues.

#### 29. What is chaos engineering?
Testing system resilience by intentionally introducing failures to identify weaknesses.

#### 30. How do you handle database migrations in CI/CD?
1. Version control migration scripts
2. Run migrations in pipeline
3. Test migrations in staging
4. Backup before production migration
5. Monitor during migration

### Architecture Questions

#### 31. Design a highly available system.
- Multi-AZ deployment
- Load balancers
- Auto-scaling
- Health checks
- Failover mechanisms
- Monitoring and alerting

#### 32. How would you migrate a monolithic application to microservices?
1. Identify bounded contexts
2. Start with one service
3. Extract service gradually
4. Implement API gateway
5. Update clients
6. Repeat for other services

#### 33. Design a CI/CD pipeline for a microservices architecture.
- Separate pipelines per service
- Shared libraries for common tasks
- Container registry
- Automated testing
- Canary/blue-green deployment
- Service mesh for communication

#### 34. How would you implement multi-cloud strategy?
- Use abstraction layers (Terraform)
- Implement cloud-agnostic tools
- Design for portability
- Manage costs across clouds
- Implement disaster recovery

#### 35. Design a monitoring and alerting system.
- Collect metrics from all services
- Centralized logging
- Distributed tracing
- Real-time dashboards
- Intelligent alerting
- Incident management integration

## Common Scenarios

### Scenario 1: Production Incident
**Question**: A production service is down. How do you respond?

**Answer**:
1. Acknowledge and assess impact
2. Check monitoring dashboards
3. Review recent deployments
4. Check logs for errors
5. Form incident response team
6. Implement fix or rollback
7. Verify resolution
8. Document post-mortem

### Scenario 2: Performance Issues
**Question**: Application is slow. How do you investigate?

**Answer**:
1. Check application metrics
2. Analyze database performance
3. Review resource usage
4. Check network latency
5. Profile application code
6. Identify bottlenecks
7. Implement optimizations

### Scenario 3: Security Breach
**Question**: Suspected security breach. What do you do?

**Answer**:
1. Contain the breach immediately
2. Assess scope and impact
3. Preserve evidence
4. Notify security team
5. Investigate root cause
6. Implement fixes
7. Review and improve security

### Scenario 4: Cost Optimization
**Question**: Cloud costs are high. How do you reduce them?

**Answer**:
1. Analyze current spending
2. Identify unused resources
3. Right-size instances
4. Use reserved instances
5. Implement auto-scaling
6. Optimize storage
7. Review and optimize regularly

### Scenario 5: New Team Member
**Question**: How do you onboard a new team member?

**Answer**:
1. Provide access and credentials
2. Share documentation
3. Review architecture
4. Pair programming sessions
5. Assign small tasks
6. Regular check-ins
7. Encourage questions

## Technical Deep Dives

### Docker Deep Dive
- Image layers and caching
- Multi-stage builds
- Docker Compose
- Docker networking
- Volume management
- Security best practices

### Kubernetes Deep Dive
- Pod lifecycle
- Deployment strategies
- Service types
- ConfigMaps and Secrets
- Persistent volumes
- Networking and ingress

### CI/CD Deep Dive
- Pipeline stages
- Parallel execution
- Artifact management
- Environment promotion
- Rollback strategies
- Pipeline optimization

### Cloud Deep Dive
- VPC design
- Security groups and NACLs
- IAM policies
- Auto-scaling
- Load balancing
- Cost optimization

## Soft Skills Questions

#### 36. How do you handle conflicting priorities?
Prioritize based on business impact, communicate with stakeholders, negotiate deadlines when needed.

#### 37. How do you explain technical concepts to non-technical people?
Use analogies, avoid jargon, focus on business value, use visual aids, check for understanding.

#### 38. How do you handle a disagreement with a team member?
Listen to their perspective, find common ground, focus on facts, involve team lead if needed, maintain professionalism.

#### 39. Describe a time you made a mistake. How did you handle it?
Acknowledge mistake, take responsibility, fix the issue, learn from it, share lessons with team.

#### 40. How do you stay motivated in your work?
Focus on learning, set goals, celebrate achievements, find interesting projects, maintain work-life balance.

## Questions to Ask Interviewer

1. What does a typical day look like for this role?
2. What are the biggest challenges the team faces?
3. What technologies does the team use?
4. How does the team handle on-call?
5. What opportunities are there for learning and growth?
6. How does the team collaborate?
7. What is the deployment frequency?
8. How does the team handle incidents?
9. What is the team structure?
10. What are the next big projects?

