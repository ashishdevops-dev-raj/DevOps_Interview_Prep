#!/usr/bin/env python3
"""
REST API Client Example
Demonstrates making HTTP requests for DevOps automation
"""

import requests
import json
import sys
from typing import Dict, Optional


class APIClient:
    """Simple REST API client for DevOps operations."""
    
    def __init__(self, base_url: str, token: Optional[str] = None):
        """
        Initialize API client.
        
        Args:
            base_url: Base URL of the API
            token: Optional authentication token
        """
        self.base_url = base_url.rstrip('/')
        self.session = requests.Session()
        
        if token:
            self.session.headers.update({
                'Authorization': f'Bearer {token}',
                'Content-Type': 'application/json'
            })
    
    def get(self, endpoint: str, params: Optional[Dict] = None) -> Dict:
        """Make GET request."""
        url = f"{self.base_url}/{endpoint.lstrip('/')}"
        response = self.session.get(url, params=params)
        response.raise_for_status()
        return response.json()
    
    def post(self, endpoint: str, data: Dict) -> Dict:
        """Make POST request."""
        url = f"{self.base_url}/{endpoint.lstrip('/')}"
        response = self.session.post(url, json=data)
        response.raise_for_status()
        return response.json()
    
    def put(self, endpoint: str, data: Dict) -> Dict:
        """Make PUT request."""
        url = f"{self.base_url}/{endpoint.lstrip('/')}"
        response = self.session.put(url, json=data)
        response.raise_for_status()
        return response.json()
    
    def delete(self, endpoint: str) -> None:
        """Make DELETE request."""
        url = f"{self.base_url}/{endpoint.lstrip('/')}"
        response = self.session.delete(url)
        response.raise_for_status()


def main():
    """Example usage."""
    # Example: GitHub API
    client = APIClient('https://api.github.com')
    
    try:
        # Get repository information
        repo_info = client.get('/repos/octocat/Hello-World')
        print("Repository Info:")
        print(json.dumps(repo_info, indent=2))
        
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()

