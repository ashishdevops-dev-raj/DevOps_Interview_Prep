# Prometheus Monitoring

## Overview
Prometheus is an open-source monitoring and alerting toolkit. It collects metrics from configured targets at given intervals, evaluates rule expressions, and triggers alerts.

## Key Concepts

### Metrics
- **Counter**: Monotonically increasing metric (e.g., total requests)
- **Gauge**: Value that can go up or down (e.g., CPU usage)
- **Histogram**: Samples observations and counts them in buckets
- **Summary**: Similar to histogram, calculates quantiles

### Components
- **Prometheus Server**: Scrapes and stores time-series data
- **Exporters**: Expose metrics from third-party systems
- **Alertmanager**: Handles alerts
- **Pushgateway**: For short-lived jobs

## Installation

### Using Docker
```bash
docker run -d \
  -p 9090:9090 \
  -v /path/to/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus
```

### Using Kubernetes
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['localhost:9090']
```

## Configuration

### Basic prometheus.yml
```yaml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
  
  - job_name: 'kubernetes-pods'
    kubernetes_sd_configs:
      - role: pod
```

## Common Exporters

### Node Exporter
Exposes hardware and OS metrics:
```bash
docker run -d -p 9100:9100 prom/node-exporter
```

### cAdvisor
Container metrics:
```bash
docker run -d -p 8080:8080 gcr.io/cadvisor/cadvisor
```

### Application Metrics
Expose metrics in your application using Prometheus client libraries.

## Querying (PromQL)

### Basic Queries
```promql
# CPU usage
100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Memory usage
node_memory_MemTotal_bytes - node_memory_MemFree_bytes

# HTTP request rate
rate(http_requests_total[5m])

# Error rate
rate(http_requests_total{status=~"5.."}[5m])
```

### Functions
```promql
# Rate
rate(metric[5m])

# Increase
increase(metric[1h])

# Sum
sum(metric)

# Average
avg(metric)

# Max/Min
max(metric)
min(metric)
```

## Alerts

### Alert Rules
```yaml
groups:
  - name: example
    rules:
      - alert: HighCPUUsage
        expr: 100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100) > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage detected"
          description: "CPU usage is above 80%"
```

## Best Practices

1. **Labeling**: Use consistent, meaningful labels
2. **Cardinality**: Avoid high cardinality labels
3. **Scrape Intervals**: Balance between detail and load
4. **Retention**: Configure appropriate retention period
5. **Alerts**: Set meaningful thresholds and durations
6. **Recording Rules**: Pre-compute expensive queries
7. **Service Discovery**: Use for dynamic environments
8. **Relabeling**: Clean and transform metrics

## Integration with Grafana

Prometheus is commonly used as a data source for Grafana dashboards, providing visualization of metrics.

## Common Use Cases

- Infrastructure monitoring
- Application performance monitoring
- Service health checks
- Capacity planning
- Alerting on anomalies

