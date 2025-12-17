# Grafana Monitoring

## Overview
Grafana is an open-source analytics and visualization platform. It allows you to query, visualize, alert on, and understand metrics from various data sources.

## Key Features

- **Dashboards**: Create and share dashboards
- **Data Sources**: Connect to Prometheus, InfluxDB, Elasticsearch, etc.
- **Alerts**: Set up alerting rules
- **Plugins**: Extend functionality with plugins
- **Templating**: Dynamic dashboards with variables

## Installation

### Using Docker
```bash
docker run -d \
  -p 3000:3000 \
  -e GF_SECURITY_ADMIN_PASSWORD=admin \
  grafana/grafana
```

### Using Kubernetes
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  replicas: 1
  selector:
    matchLabels:
      app: grafana
  template:
    metadata:
      labels:
        app: grafana
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        ports:
        - containerPort: 3000
```

## Configuration

### Data Sources

#### Prometheus
1. Go to Configuration → Data Sources
2. Add Prometheus
3. Set URL: `http://prometheus:9090`
4. Save & Test

#### Other Data Sources
- InfluxDB
- Elasticsearch
- CloudWatch
- Azure Monitor
- MySQL/PostgreSQL

## Dashboards

### Creating Dashboards

1. **Add Panel**: Click "Add panel"
2. **Choose Visualization**: Graph, Stat, Table, etc.
3. **Configure Query**: Write PromQL or query language
4. **Customize**: Set titles, units, colors
5. **Save**: Save dashboard

### Dashboard Variables

Create dynamic dashboards:
```
Variable: $namespace
Type: Query
Query: label_values(namespace)
```

Use in queries:
```promql
rate(http_requests_total{namespace="$namespace"}[5m])
```

### Import Dashboards

Import pre-built dashboards:
1. Go to Dashboards → Import
2. Enter dashboard ID (from grafana.com)
3. Configure data source
4. Import

Popular dashboards:
- Node Exporter: 1860
- Kubernetes: 7249
- Docker: 893

## Alerting

### Create Alert

1. **Add Alert Rule**: In panel settings
2. **Set Conditions**: Define threshold
3. **Configure Notifications**: Email, Slack, PagerDuty
4. **Test**: Verify alert works

### Alert Channels

- Email
- Slack
- PagerDuty
- Webhook
- Teams

### Alert Example
```yaml
Condition: WHEN avg() OF query(A, 5m, now) IS ABOVE 80
Evaluation: Evaluate every 1m for 5m
```

## Best Practices

1. **Dashboard Organization**: Use folders and tags
2. **Naming Conventions**: Consistent naming
3. **Variables**: Use for dynamic dashboards
4. **Refresh Intervals**: Set appropriate intervals
5. **Annotations**: Mark important events
6. **Permissions**: Control access with roles
7. **Backup**: Export dashboards as JSON
8. **Performance**: Optimize queries
9. **Documentation**: Add descriptions
10. **Version Control**: Store dashboards in Git

## Common Dashboards

### Infrastructure
- CPU usage
- Memory usage
- Disk I/O
- Network traffic
- System load

### Applications
- Request rate
- Error rate
- Response time
- Throughput
- Active users

### Kubernetes
- Pod status
- Resource usage
- Node metrics
- Deployment status

## Query Examples

### Prometheus Queries
```promql
# CPU Usage
100 - (avg(irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)

# Memory Usage
(node_memory_MemTotal_bytes - node_memory_MemFree_bytes) / node_memory_MemTotal_bytes * 100

# Request Rate
rate(http_requests_total[5m])

# Error Rate
rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) * 100
```

## Plugins

### Install Plugins
```bash
grafana-cli plugins install <plugin-name>
```

### Popular Plugins
- **Clock Panel**: Display time
- **Worldmap Panel**: Geographic visualization
- **Pie Chart**: Pie chart visualization
- **Stat Panel**: Single stat display

## API

### Create Dashboard via API
```bash
curl -X POST http://admin:admin@localhost:3000/api/dashboards/db \
  -H "Content-Type: application/json" \
  -d @dashboard.json
```

### Export Dashboard
```bash
curl http://admin:admin@localhost:3000/api/dashboards/uid/<uid> > dashboard.json
```

## Integration

### With Prometheus
- Primary data source
- Real-time metrics
- Historical data

### With Loki
- Log aggregation
- Log queries
- Correlate logs with metrics

### With Alertmanager
- Alert routing
- Notification management
- Alert grouping

## Troubleshooting

### Common Issues
- **Data Source Connection**: Check URL and credentials
- **No Data**: Verify query syntax and time range
- **Performance**: Optimize queries, reduce refresh rate
- **Permissions**: Check user roles and permissions

## Security

### Best Practices
- Change default admin password
- Use strong passwords
- Enable HTTPS
- Configure LDAP/OAuth
- Set up proper user roles
- Regular updates

