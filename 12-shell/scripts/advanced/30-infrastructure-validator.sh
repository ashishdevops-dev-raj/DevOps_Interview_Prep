#!/bin/bash
# Advanced Level Script 30: Infrastructure Validator
# Validate infrastructure configuration and state

set -euo pipefail

VALIDATION_REPORT="./infrastructure-validation-$(date +%Y%m%d_%H%M%S).json"
ERRORS=0
WARNINGS=0

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

validate_disk_space() {
    local threshold=85
    local usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ $usage -gt $threshold ]; then
        log "ERROR: Disk usage ${usage}% exceeds threshold ${threshold}%"
        ((ERRORS++))
        echo "{\"check\":\"disk_space\",\"status\":\"error\",\"usage\":\"${usage}%\"}"
    elif [ $usage -gt 70 ]; then
        log "WARNING: Disk usage ${usage}% is above 70%"
        ((WARNINGS++))
        echo "{\"check\":\"disk_space\",\"status\":\"warning\",\"usage\":\"${usage}%\"}"
    else
        echo "{\"check\":\"disk_space\",\"status\":\"ok\",\"usage\":\"${usage}%\"}"
    fi
}

validate_services() {
    local required_services=("ssh" "docker" "kubelet")
    local results=()
    
    for service in "${required_services[@]}"; do
        if systemctl is-active --quiet "$service" 2>/dev/null; then
            results+=("{\"service\":\"$service\",\"status\":\"ok\"}")
        else
            log "ERROR: Service $service is not running"
            ((ERRORS++))
            results+=("{\"service\":\"$service\",\"status\":\"error\"}")
        fi
    done
    
    IFS=','
    echo "[${results[*]}]"
}

validate_ports() {
    local required_ports=(22 80 443 6443)
    local results=()
    
    for port in "${required_ports[@]}"; do
        if ss -tuln | grep -q ":$port "; then
            results+=("{\"port\":\"$port\",\"status\":\"ok\"}")
        else
            log "WARNING: Port $port is not listening"
            ((WARNINGS++))
            results+=("{\"port\":\"$port\",\"status\":\"warning\"}")
        fi
    done
    
    IFS=','
    echo "[${results[*]}]"
}

validate_certificates() {
    local cert_paths=("/etc/ssl/certs" "/etc/pki")
    local results=()
    
    for path in "${cert_paths[@]}"; do
        if [ -d "$path" ]; then
            local cert_count=$(find "$path" -name "*.crt" -o -name "*.pem" 2>/dev/null | wc -l)
            results+=("{\"path\":\"$path\",\"status\":\"ok\",\"certificates\":\"$cert_count\"}")
        else
            log "WARNING: Certificate path not found: $path"
            ((WARNINGS++))
            results+=("{\"path\":\"$path\",\"status\":\"warning\"}")
        fi
    done
    
    IFS=','
    echo "[${results[*]}]"
}

validate_connectivity() {
    local endpoints=("google.com:80" "github.com:443")
    local results=()
    
    for endpoint in "${endpoints[@]}"; do
        IFS=':' read -r host port <<< "$endpoint"
        if timeout 3 bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
            results+=("{\"endpoint\":\"$endpoint\",\"status\":\"ok\"}")
        else
            log "WARNING: Cannot reach $endpoint"
            ((WARNINGS++))
            results+=("{\"endpoint\":\"$endpoint\",\"status\":\"warning\"}")
        fi
    done
    
    IFS=','
    echo "[${results[*]}]"
}

main() {
    log "=== Infrastructure Validation ==="
    
    {
        echo "{"
        echo "  \"timestamp\": \"$(date -Iseconds)\","
        echo "  \"hostname\": \"$(hostname)\","
        echo "  \"validations\": {"
        echo "    \"disk_space\": $(validate_disk_space),"
        echo "    \"services\": $(validate_services),"
        echo "    \"ports\": $(validate_ports),"
        echo "    \"certificates\": $(validate_certificates),"
        echo "    \"connectivity\": $(validate_connectivity)"
        echo "  },"
        echo "  \"summary\": {"
        echo "    \"errors\": $ERRORS,"
        echo "    \"warnings\": $WARNINGS"
        echo "  }"
        echo "}"
    } | tee "$VALIDATION_REPORT" | jq '.' 2>/dev/null || cat "$VALIDATION_REPORT"
    
    log ""
    log "Validation complete:"
    log "  Errors: $ERRORS"
    log "  Warnings: $WARNINGS"
    log "  Report: $VALIDATION_REPORT"
    
    [ $ERRORS -eq 0 ] && exit 0 || exit 1
}

main "$@"

