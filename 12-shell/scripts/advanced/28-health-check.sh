#!/bin/bash
# Advanced Level Script 28: Health Check System
# Comprehensive health check with multiple endpoints

set -euo pipefail

HEALTH_CHECK_FILE="./health-status.json"
TIMEOUT=5

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

check_http_endpoint() {
    local url="$1"
    local name="$2"
    
    if curl -sf --max-time $TIMEOUT "$url" > /dev/null 2>&1; then
        echo "{\"service\":\"$name\",\"status\":\"healthy\",\"endpoint\":\"$url\"}"
        return 0
    else
        echo "{\"service\":\"$name\",\"status\":\"unhealthy\",\"endpoint\":\"$url\"}"
        return 1
    fi
}

check_port() {
    local host="$1"
    local port="$2"
    local name="$3"
    
    if timeout $TIMEOUT bash -c "echo > /dev/tcp/$host/$port" 2>/dev/null; then
        echo "{\"service\":\"$name\",\"status\":\"healthy\",\"port\":\"$port\"}"
        return 0
    else
        echo "{\"service\":\"$name\",\"status\":\"unhealthy\",\"port\":\"$port\"}"
        return 1
    fi
}

check_process() {
    local process="$1"
    
    if pgrep -f "$process" > /dev/null; then
        echo "{\"service\":\"$process\",\"status\":\"healthy\"}"
        return 0
    else
        echo "{\"service\":\"$process\",\"status\":\"unhealthy\"}"
        return 1
    fi
}

check_disk_space() {
    local threshold=80
    local usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    
    if [ $usage -lt $threshold ]; then
        echo "{\"service\":\"disk\",\"status\":\"healthy\",\"usage\":\"${usage}%\"}"
        return 0
    else
        echo "{\"service\":\"disk\",\"status\":\"unhealthy\",\"usage\":\"${usage}%\"}"
        return 1
    fi
}

main() {
    local overall_status="healthy"
    local checks=()
    
    log "Starting health checks..."
    
    # HTTP endpoints
    if [ -n "${HTTP_ENDPOINTS:-}" ]; then
        while IFS=',' read -r name url; do
            result=$(check_http_endpoint "$url" "$name")
            checks+=("$result")
            echo "$result" | grep -q "unhealthy" && overall_status="unhealthy"
        done <<< "$HTTP_ENDPOINTS"
    fi
    
    # Port checks
    if [ -n "${PORT_CHECKS:-}" ]; then
        while IFS=',' read -r name host port; do
            result=$(check_port "$host" "$port" "$name")
            checks+=("$result")
            echo "$result" | grep -q "unhealthy" && overall_status="unhealthy"
        done <<< "$PORT_CHECKS"
    fi
    
    # Process checks
    if [ -n "${PROCESS_CHECKS:-}" ]; then
        while IFS=',' read -r process; do
            result=$(check_process "$process")
            checks+=("$result")
            echo "$result" | grep -q "unhealthy" && overall_status="unhealthy"
        done <<< "$PROCESS_CHECKS"
    fi
    
    # System checks
    disk_result=$(check_disk_space)
    checks+=("$disk_result")
    echo "$disk_result" | grep -q "unhealthy" && overall_status="unhealthy"
    
    # Generate JSON report
    {
        echo "{"
        echo "  \"timestamp\": \"$(date -Iseconds)\","
        echo "  \"overall_status\": \"$overall_status\","
        echo "  \"checks\": ["
        printf '    %s' "$(IFS=','; echo "${checks[*]}")" | sed 's/}{/},\n    {/g'
        echo ""
        echo "  ]"
        echo "}"
    } > "$HEALTH_CHECK_FILE"
    
    log "Health check complete. Status: $overall_status"
    log "Report saved to: $HEALTH_CHECK_FILE"
    
    [ "$overall_status" = "healthy" ] && exit 0 || exit 1
}

main "$@"

