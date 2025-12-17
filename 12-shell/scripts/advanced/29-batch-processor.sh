#!/bin/bash
# Advanced Level Script 29: Batch Processor
# Process multiple files/jobs in parallel with progress tracking

set -euo pipefail

MAX_PARALLEL="${MAX_PARALLEL:-4}"
LOG_DIR="./batch-logs"
PROCESSED=0
FAILED=0

mkdir -p "$LOG_DIR"

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

process_file() {
    local file="$1"
    local log_file="$LOG_DIR/$(basename $file).log"
    
    {
        echo "Processing: $file"
        # Add your processing logic here
        # Example: convert, transform, analyze, etc.
        sleep 1  # Simulate processing
        echo "Completed: $file"
    } > "$log_file" 2>&1
    
    if [ $? -eq 0 ]; then
        echo "SUCCESS:$file"
    else
        echo "FAILED:$file"
    fi
}

export -f process_file log

main() {
    local input_list="${1:-}"
    
    if [ -z "$input_list" ] || [ ! -f "$input_list" ]; then
        echo "Usage: $0 <file-list.txt>"
        echo "File list should contain one file path per line"
        exit 1
    fi
    
    log "Starting batch processing..."
    log "Max parallel jobs: $MAX_PARALLEL"
    log "Input file: $input_list"
    
    # Process files in parallel
    local total=$(wc -l < "$input_list")
    log "Total files to process: $total"
    
    # Use xargs for parallel processing
    cat "$input_list" | xargs -P "$MAX_PARALLEL" -I {} bash -c 'process_file "$@"' _ {} | while read result; do
        if [[ $result == SUCCESS:* ]]; then
            ((PROCESSED++))
            log "✓ $(echo $result | cut -d: -f2-)"
        else
            ((FAILED++))
            log "✗ $(echo $result | cut -d: -f2-)"
        fi
    done
    
    log ""
    log "=== Batch Processing Complete ==="
    log "Total: $total"
    log "Processed: $PROCESSED"
    log "Failed: $FAILED"
    log "Logs directory: $LOG_DIR"
    
    [ $FAILED -eq 0 ] && exit 0 || exit 1
}

main "$@"

