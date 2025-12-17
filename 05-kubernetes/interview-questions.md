# Kubernetes Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Kubernetes?
Kubernetes (K8s) is an open-source container orchestration platform that automates deployment, scaling, and management of containerized applications.

### 2. What does K8s stand for?
K8s is an abbreviation for Kubernetes (K + 8 letters + s).

### 3. What are the main components of Kubernetes?
- **Master Node**: API Server, etcd, Controller Manager, Scheduler
- **Worker Node**: Kubelet, Kube-proxy, Container Runtime
- **Add-ons**: DNS, Dashboard, Monitoring

### 4. What is a Pod?
A Pod is the smallest deployable unit in Kubernetes. It contains one or more containers that share storage, network, and specifications.

### 5. What is a Node?
A Node is a worker machine in Kubernetes. Can be a physical or virtual machine. Each node runs pods.

### 6. What is a Cluster?
A cluster is a set of nodes (masters and workers) that run containerized applications managed by Kubernetes.

### 7. How do you check cluster information?
```bash
kubectl cluster-info
kubectl get nodes
```

### 8. What is a Namespace?
A Namespace provides logical separation of resources in a cluster. Resources are scoped to namespaces.

### 9. How do you create a namespace?
```bash
kubectl create namespace <name>
```

### 10. What are default namespaces?
- `default`: Default namespace
- `kube-system`: System components
- `kube-public`: Publicly accessible data
- `kube-node-lease`: Node heartbeat

### 11. How do you list pods?
```bash
kubectl get pods
kubectl get pods -A  # All namespaces
kubectl get pods -n <namespace>
```

### 12. How do you describe a pod?
```bash
kubectl describe pod <pod-name>
```

### 13. How do you view pod logs?
```bash
kubectl logs <pod-name>
kubectl logs -f <pod-name>  # Follow logs
```

### 14. How do you execute a command in a pod?
```bash
kubectl exec -it <pod-name> -- /bin/sh
kubectl exec <pod-name> -- <command>
```

### 15. What is a Deployment?
A Deployment provides declarative updates for Pods and ReplicaSets. It manages desired state, rolling updates, and rollbacks.

### 16. How do you create a deployment?
```bash
kubectl create deployment <name> --image=<image>
kubectl apply -f deployment.yaml
```

### 17. How do you list deployments?
```bash
kubectl get deployments
kubectl get deploy  # Short form
```

### 18. How do you scale a deployment?
```bash
kubectl scale deployment/<name> --replicas=5
```

### 19. What is a Service?
A Service provides stable network access to a set of Pods. It abstracts pod IPs and provides load balancing.

### 20. What are the types of Services?
- **ClusterIP**: Internal cluster IP (default)
- **NodePort**: Exposes service on each node's IP at a static port
- **LoadBalancer**: Exposes service externally using cloud provider's load balancer
- **ExternalName**: Maps service to external DNS name

### 21. How do you create a service?
```bash
kubectl expose deployment <name> --port=80 --type=LoadBalancer
kubectl apply -f service.yaml
```

### 22. How do you list services?
```bash
kubectl get services
kubectl get svc  # Short form
```

### 23. What is a ConfigMap?
A ConfigMap stores non-confidential configuration data as key-value pairs. Can be mounted as volumes or environment variables.

### 24. How do you create a ConfigMap?
```bash
kubectl create configmap <name> --from-literal=key=value
kubectl create configmap <name> --from-file=file.txt
```

### 25. What is a Secret?
A Secret stores sensitive data (passwords, tokens, keys). Similar to ConfigMap but base64 encoded.

### 26. How do you create a Secret?
```bash
kubectl create secret generic <name> --from-literal=key=value
kubectl create secret generic <name> --from-file=./file
```

### 27. What is the difference between ConfigMap and Secret?
- **ConfigMap**: Plain text configuration
- **Secret**: Base64 encoded (not encrypted), for sensitive data

### 28. How do you apply a YAML file?
```bash
kubectl apply -f file.yaml
kubectl apply -f directory/
```

### 29. How do you delete a resource?
```bash
kubectl delete pod <pod-name>
kubectl delete -f file.yaml
```

### 30. How do you edit a resource?
```bash
kubectl edit deployment <name>
kubectl edit pod <pod-name>
```

### 31. What is kubectl?
kubectl is the command-line tool for interacting with Kubernetes clusters.

### 32. How do you check kubectl version?
```bash
kubectl version
```

### 33. How do you check cluster connectivity?
```bash
kubectl cluster-info
kubectl get nodes
```

### 34. What is a label?
A label is a key-value pair attached to objects for identification and selection.

### 35. How do you filter resources by label?
```bash
kubectl get pods -l app=myapp
kubectl get pods --selector=app=myapp
```

## Medium Level (Questions 36-70)

### 36. Explain Kubernetes master components.
- **API Server**: Entry point for all REST commands
- **etcd**: Distributed key-value store (cluster state)
- **Controller Manager**: Runs controllers (replication, endpoints, etc.)
- **Scheduler**: Assigns pods to nodes

### 37. Explain Kubernetes worker node components.
- **Kubelet**: Agent that communicates with master, manages pods
- **Kube-proxy**: Network proxy maintaining network rules
- **Container Runtime**: Runs containers (Docker, containerd, etc.)

### 38. What is etcd?
etcd is a distributed, consistent key-value store used by Kubernetes to store cluster state and configuration.

### 39. What is the API Server?
The API Server is the front-end for Kubernetes control plane. It validates and processes REST requests, updates etcd, and communicates with other components.

### 40. What is the Scheduler?
The Scheduler assigns pods to nodes based on resource requirements, constraints, and policies.

### 41. What is the Controller Manager?
The Controller Manager runs controllers that regulate the state of the cluster (replication, endpoints, etc.).

### 42. Can a Pod have multiple containers?
Yes, a Pod can have multiple containers that share:
- Network namespace (same IP)
- Storage volumes
- IPC namespace

### 43. What is the difference between a Pod and a Container?
- **Container**: Runtime instance of an image
- **Pod**: Kubernetes abstraction that wraps one or more containers

### 44. What is a sidecar container?
A sidecar container runs alongside the main container in a Pod, providing supporting functionality (logging, monitoring, etc.).

### 45. What are init containers?
Init containers run before the main containers in a Pod. They're used for setup tasks and must complete successfully before main containers start.

### 46. What is a ReplicaSet?
A ReplicaSet ensures a specified number of pod replicas are running. Deployments use ReplicaSets for pod management.

### 47. What is the difference between Deployment and ReplicaSet?
- **ReplicaSet**: Low-level controller ensuring pod replicas
- **Deployment**: Higher-level abstraction managing ReplicaSets with rolling updates

### 48. Explain rolling update strategy.
Rolling update gradually replaces old pods with new ones, ensuring zero downtime. Controlled by `maxSurge` and `maxUnavailable`.

### 49. How do you rollback a deployment?
```bash
kubectl rollout undo deployment/<name>
kubectl rollout undo deployment/<name> --to-revision=2
```

### 50. How do you check rollout status?
```bash
kubectl rollout status deployment/<name>
kubectl rollout history deployment/<name>
```

### 51. What is the difference between ClusterIP and NodePort?
- **ClusterIP**: Only accessible within cluster
- **NodePort**: Accessible from outside cluster via node IP and port

### 52. What is a Headless Service?
A Headless Service (clusterIP: None) doesn't provide load balancing. Returns individual pod IPs, useful for StatefulSets.

### 53. How do Pods communicate?
Pods can communicate using:
- Pod IP addresses
- Service names (DNS)
- Environment variables

### 54. What is kube-proxy?
kube-proxy maintains network rules on nodes, enabling service abstraction and load balancing.

### 55. What is CNI?
Container Network Interface (CNI) is a specification for network plugins in Kubernetes (Calico, Flannel, Weave, etc.).

### 56. What is a Volume?
A Volume provides persistent storage for Pods. Data persists across container restarts.

### 57. What are the types of Volumes?
- **emptyDir**: Temporary storage (lost when pod deleted)
- **hostPath**: Node's filesystem
- **PersistentVolumeClaim**: Persistent storage
- **ConfigMap/Secret**: Mounted as volumes

### 58. What is a PersistentVolume (PV)?
A PV is a cluster-wide storage resource provisioned by an administrator or dynamically.

### 59. What is a PersistentVolumeClaim (PVC)?
A PVC is a request for storage by a user. Binds to a PV.

### 60. How do you create a PVC?
```bash
kubectl apply -f pvc.yaml
```

### 61. What is a StatefulSet?
A StatefulSet manages stateful applications. Provides:
- Stable network identities
- Ordered deployment/scaling
- Persistent storage

### 62. What is a DaemonSet?
A DaemonSet ensures all (or specific) nodes run a copy of a Pod. Used for node-level services (logging, monitoring).

### 63. When to use StatefulSet vs Deployment?
- **Deployment**: Stateless applications
- **StatefulSet**: Stateful applications requiring stable identities, ordered deployment, persistent storage

### 64. What is a Job?
A Job creates one or more Pods and ensures they complete successfully. Used for batch/one-time tasks.

### 65. What is a CronJob?
A CronJob runs Jobs on a time-based schedule (cron syntax).

### 66. What are resource requests and limits?
- **Requests**: Guaranteed resources (scheduling)
- **Limits**: Maximum resources (throttling)

### 67. How do you set resource limits?
```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "250m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

### 68. What is a ResourceQuota?
ResourceQuota limits resource consumption per namespace (CPU, memory, pods, etc.).

### 69. What is a LimitRange?
LimitRange sets default/min/max resource constraints for Pods in a namespace.

### 70. What are liveness and readiness probes?
- **Liveness Probe**: Determines if container is running (restarts if fails)
- **Readiness Probe**: Determines if container is ready to serve traffic

## High/Advanced Level (Questions 71-100)

### 71. What are the types of probes?
- **HTTP**: HTTP GET request
- **TCP**: TCP connection check
- **Exec**: Execute command

### 72. How do you configure probes?
```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
```

### 73. What is RBAC?
Role-Based Access Control (RBAC) controls access to Kubernetes resources based on roles and bindings.

### 74. What is a ServiceAccount?
A ServiceAccount provides identity for Pods. Used for API access and authentication.

### 75. How do you create a ServiceAccount?
```bash
kubectl create serviceaccount <name>
```

### 76. What is a NetworkPolicy?
NetworkPolicy controls network traffic between Pods (ingress/egress rules).

### 77. How do you create a NetworkPolicy?
```bash
kubectl apply -f networkpolicy.yaml
```

### 78. What is HPA (Horizontal Pod Autoscaler)?
HPA automatically scales pods based on CPU/memory usage or custom metrics.

### 79. How do you create an HPA?
```bash
kubectl autoscale deployment <name> --min=2 --max=10 --cpu-percent=80
```

### 80. What is VPA (Vertical Pod Autoscaler)?
VPA automatically adjusts pod resource requests/limits based on usage.

### 81. What is Cluster Autoscaler?
Cluster Autoscaler automatically adjusts the number of nodes in a cluster based on demand.

### 82. How do you update a deployment?
```bash
kubectl set image deployment/<name> <container>=<image>:<tag>
kubectl rollout status deployment/<name>
```

### 83. What is a Pod Disruption Budget (PDB)?
PDB limits the number of pods that can be voluntarily disrupted during maintenance.

### 84. How do you create a PDB?
```bash
kubectl apply -f pdb.yaml
```

### 85. What is a Custom Resource Definition (CRD)?
CRD allows extending Kubernetes API with custom resources.

### 86. What is an Operator?
An Operator is a method of packaging, deploying, and managing a Kubernetes application using CRDs.

### 87. What is Helm?
Helm is a package manager for Kubernetes that simplifies application deployment.

### 88. How do you install Helm chart?
```bash
helm install <name> <chart>
```

### 89. What is Ingress?
Ingress exposes HTTP/HTTPS routes from outside the cluster to services within the cluster.

### 90. How do you create an Ingress?
```bash
kubectl apply -f ingress.yaml
```

### 91. What is an Ingress Controller?
An Ingress Controller is a reverse proxy that implements Ingress rules (e.g., NGINX, Traefik).

### 92. What is a Pod Security Policy (PSP)?
PSP defines security conditions that pods must meet to be accepted into the cluster (deprecated in favor of Pod Security Standards).

### 93. What is Pod Security Standards?
Pod Security Standards define security policies for pods (restricted, baseline, privileged).

### 94. What is etcd backup?
etcd backup is crucial for disaster recovery. Backup etcd data regularly.

### 95. How do you backup etcd?
```bash
ETCDCTL_API=3 etcdctl snapshot save snapshot.db
```

### 96. What is Kubernetes API versioning?
Kubernetes API uses versioning (v1, v1beta1, etc.) to manage API evolution.

### 97. What is a Custom Resource (CR)?
A Custom Resource is an extension of the Kubernetes API using CRDs.

### 98. What is Admission Controller?
Admission Controllers intercept requests to the API server before object persistence, enabling validation and mutation.

### 99. What are Kubernetes best practices?
- Use Deployments instead of Pods
- Set resource requests/limits
- Use namespaces for organization
- Implement health checks
- Use ConfigMaps/Secrets for configuration
- Use labels and selectors effectively
- Implement RBAC
- Use readiness/liveness probes
- Avoid using `latest` tag
- Use Horizontal Pod Autoscaler

### 100. How do you debug a Pod that's not starting?
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl get events
kubectl exec -it <pod-name> -- /bin/sh
kubectl get events --field-selector involvedObject.name=<pod-name>
```
