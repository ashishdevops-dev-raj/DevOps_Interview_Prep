# Kubernetes Commands Cheat Sheet

## Cluster Information

```bash
kubectl cluster-info                    # Cluster information
kubectl get nodes                       # List nodes
kubectl describe node <node-name>       # Node details
kubectl get componentstatuses           # Component status
kubectl version                         # Client and server version
```

## Namespaces

```bash
kubectl get namespaces                  # List namespaces
kubectl create namespace <name>         # Create namespace
kubectl delete namespace <name>         # Delete namespace
kubectl config set-context --current --namespace=<name>  # Set default namespace
```

## Pods

```bash
kubectl get pods                        # List pods
kubectl get pods -A                     # List all pods (all namespaces)
kubectl get pods -o wide                # List pods with details
kubectl get pods -l app=myapp           # List pods by label
kubectl describe pod <pod-name>        # Pod details
kubectl logs <pod-name>                 # Pod logs
kubectl logs -f <pod-name>              # Follow logs
kubectl logs <pod-name> -c <container> # Container logs in pod
kubectl exec -it <pod-name> -- /bin/sh  # Execute command in pod
kubectl delete pod <pod-name>          # Delete pod
kubectl port-forward <pod-name> 8080:80 # Port forward
```

## Deployments

```bash
kubectl get deployments                # List deployments
kubectl describe deployment <name>     # Deployment details
kubectl create deployment <name> --image=<image>  # Create deployment
kubectl apply -f deployment.yaml       # Apply deployment
kubectl delete deployment <name>       # Delete deployment
kubectl scale deployment <name> --replicas=3  # Scale deployment
kubectl rollout status deployment <name>  # Rollout status
kubectl rollout history deployment <name>  # Rollout history
kubectl rollout undo deployment <name>  # Rollback deployment
kubectl set image deployment <name> <container>=<image>  # Update image
kubectl rollout pause deployment <name>  # Pause rollout
kubectl rollout resume deployment <name>  # Resume rollout
```

## Services

```bash
kubectl get services                    # List services
kubectl get svc                         # Short form
kubectl describe service <name>        # Service details
kubectl expose deployment <name> --port=80 --type=LoadBalancer  # Expose deployment
kubectl delete service <name>          # Delete service
```

## ConfigMaps and Secrets

```bash
kubectl get configmaps                  # List configmaps
kubectl create configmap <name> --from-literal=key=value  # Create configmap
kubectl create configmap <name> --from-file=file.txt  # From file
kubectl describe configmap <name>      # ConfigMap details
kubectl get secrets                     # List secrets
kubectl create secret generic <name> --from-literal=key=value  # Create secret
kubectl describe secret <name>         # Secret details
```

## Jobs and CronJobs

```bash
kubectl get jobs                        # List jobs
kubectl describe job <name>            # Job details
kubectl delete job <name>              # Delete job
kubectl get cronjobs                    # List cronjobs
kubectl create cronjob <name> --image=<image> --schedule="0 * * * *"  # Create cronjob
```

## StatefulSets and DaemonSets

```bash
kubectl get statefulsets                # List statefulsets
kubectl get daemonsets                 # List daemonsets
kubectl describe statefulset <name>    # StatefulSet details
kubectl describe daemonset <name>      # DaemonSet details
```

## Resource Management

```bash
kubectl top nodes                       # Node resource usage
kubectl top pods                        # Pod resource usage
kubectl get pods --sort-by=.metadata.creationTimestamp  # Sort pods
kubectl get all                         # Get all resources
```

## YAML Operations

```bash
kubectl apply -f file.yaml              # Apply configuration
kubectl apply -f directory/             # Apply all files in directory
kubectl delete -f file.yaml            # Delete from file
kubectl get <resource> -o yaml         # Output as YAML
kubectl get <resource> -o json         # Output as JSON
kubectl explain <resource>             # Documentation for resource
```

## Debugging

```bash
kubectl get events                      # List events
kubectl get events --sort-by=.metadata.creationTimestamp  # Sorted events
kubectl logs <pod-name> --previous     # Previous container logs
kubectl exec <pod-name> -- env         # Environment variables
kubectl cp <pod-name>:/path /local/path  # Copy from pod
kubectl cp /local/path <pod-name>:/path  # Copy to pod
kubectl attach <pod-name>              # Attach to running container
```

## Labels and Selectors

```bash
kubectl get pods -l app=myapp          # Filter by label
kubectl label pod <pod-name> env=prod  # Add label
kubectl label pod <pod-name> env-      # Remove label
kubectl get pods --selector=app=myapp  # Using selector
```

## Context and Configuration

```bash
kubectl config view                     # View config
kubectl config get-contexts            # List contexts
kubectl config use-context <name>      # Switch context
kubectl config set-context --current --namespace=<name>  # Set namespace
kubectl config current-context         # Current context
```

## Advanced Commands

```bash
kubectl api-resources                  # List all API resources
kubectl api-versions                   # List API versions
kubectl auth can-i <verb> <resource>  # Check permissions
kubectl get <resource> --watch        # Watch resources
kubectl patch deployment <name> -p '{"spec":{"replicas":5}}'  # Patch resource
kubectl edit deployment <name>        # Edit resource
kubectl replace -f file.yaml          # Replace resource
```

## Helm Commands (if using Helm)

```bash
helm list                              # List releases
helm install <name> <chart>           # Install chart
helm upgrade <name> <chart>           # Upgrade release
helm uninstall <name>                 # Uninstall release
helm status <name>                    # Release status
helm rollback <name> <revision>      # Rollback release
```

## Useful Aliases

```bash
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias ke='kubectl exec -it'
```

## Common Workflows

### Deploy Application
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get pods -w
kubectl logs -f <pod-name>
```

### Update Application
```bash
kubectl set image deployment/myapp myapp=myapp:2.0.0
kubectl rollout status deployment/myapp
kubectl rollout history deployment/myapp
```

### Debug Pod Issues
```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl exec -it <pod-name> -- /bin/sh
kubectl get events --field-selector involvedObject.name=<pod-name>
```

### Scale Application
```bash
kubectl scale deployment/myapp --replicas=5
kubectl autoscale deployment/myapp --min=2 --max=10 --cpu-percent=80
```

