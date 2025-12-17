#!/usr/bin/env python3
"""
DevOps Utility Scripts
Common functions for DevOps automation
"""

import os
import sys
import json
import subprocess
import logging
from pathlib import Path
from typing import Dict, List, Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


def execute_command(command: List[str], check: bool = True) -> subprocess.CompletedProcess:
    """
    Execute a shell command and return the result.
    
    Args:
        command: List of command and arguments
        check: Raise exception on non-zero exit code
    
    Returns:
        CompletedProcess object
    """
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=check
        )
        logger.info(f"Command executed: {' '.join(command)}")
        return result
    except subprocess.CalledProcessError as e:
        logger.error(f"Command failed: {e}")
        raise


def read_json_file(file_path: str) -> Dict:
    """Read and parse JSON file."""
    try:
        with open(file_path, 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        logger.error(f"File not found: {file_path}")
        raise
    except json.JSONDecodeError as e:
        logger.error(f"Invalid JSON: {e}")
        raise


def write_json_file(data: Dict, file_path: str, indent: int = 2) -> None:
    """Write data to JSON file."""
    with open(file_path, 'w') as f:
        json.dump(data, f, indent=indent)
    logger.info(f"Data written to {file_path}")


def check_disk_usage(path: str = '/') -> Dict[str, float]:
    """
    Check disk usage for a given path.
    
    Returns:
        Dictionary with total, used, and free space in GB
    """
    import shutil
    
    total, used, free = shutil.disk_usage(path)
    
    return {
        'total': total / (1024**3),  # Convert to GB
        'used': used / (1024**3),
        'free': free / (1024**3),
        'percent_used': (used / total) * 100
    }


def get_environment_variable(name: str, default: Optional[str] = None) -> str:
    """Get environment variable with optional default."""
    value = os.getenv(name, default)
    if value is None:
        raise ValueError(f"Environment variable {name} not set")
    return value


def create_directory(path: str, parents: bool = True) -> None:
    """Create directory if it doesn't exist."""
    Path(path).mkdir(parents=parents, exist_ok=True)
    logger.info(f"Directory created/verified: {path}")


def file_exists(file_path: str) -> bool:
    """Check if file exists."""
    return Path(file_path).exists()


def read_file_lines(file_path: str) -> List[str]:
    """Read file and return lines as list."""
    with open(file_path, 'r') as f:
        return [line.strip() for line in f.readlines()]


def write_file(content: str, file_path: str) -> None:
    """Write content to file."""
    with open(file_path, 'w') as f:
        f.write(content)
    logger.info(f"Content written to {file_path}")


def parse_log_file(file_path: str, pattern: str = None) -> List[str]:
    """
    Parse log file and optionally filter by pattern.
    
    Args:
        file_path: Path to log file
        pattern: Optional regex pattern to filter lines
    
    Returns:
        List of matching lines
    """
    import re
    
    lines = read_file_lines(file_path)
    
    if pattern:
        regex = re.compile(pattern)
        return [line for line in lines if regex.search(line)]
    
    return lines


def get_system_info() -> Dict:
    """Get system information."""
    import platform
    
    return {
        'system': platform.system(),
        'release': platform.release(),
        'version': platform.version(),
        'machine': platform.machine(),
        'processor': platform.processor(),
        'python_version': platform.python_version()
    }


def main():
    """Main function for testing."""
    print("DevOps Utility Functions")
    print("=" * 50)
    
    # Example: Check disk usage
    disk_info = check_disk_usage()
    print(f"\nDisk Usage:")
    print(f"  Total: {disk_info['total']:.2f} GB")
    print(f"  Used: {disk_info['used']:.2f} GB ({disk_info['percent_used']:.2f}%)")
    print(f"  Free: {disk_info['free']:.2f} GB")
    
    # Example: System info
    sys_info = get_system_info()
    print(f"\nSystem Information:")
    for key, value in sys_info.items():
        print(f"  {key}: {value}")


if __name__ == '__main__':
    main()

