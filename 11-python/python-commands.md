# Python Commands & Reference

## Basic Python Commands

### Running Python
```bash
python script.py              # Run Python 2/3 script
python3 script.py             # Run Python 3 script
python -m module              # Run module as script
python -c "print('Hello')"   # Execute Python code
python -i script.py           # Run script and enter interactive mode
```

### Python Interactive Shell
```bash
python                        # Start Python REPL
python3                       # Start Python 3 REPL
ipython                       # Enhanced Python shell
```

### Package Management
```bash
pip install package           # Install package
pip install -r requirements.txt  # Install from requirements file
pip uninstall package         # Uninstall package
pip list                      # List installed packages
pip show package              # Show package information
pip freeze                    # Output installed packages
pip freeze > requirements.txt # Save dependencies
pip search package            # Search for packages
pip install --upgrade package # Upgrade package
```

### Virtual Environments
```bash
python -m venv venv          # Create virtual environment
python3 -m venv venv         # Create Python 3 venv
source venv/bin/activate     # Activate (Linux/Mac)
venv\Scripts\activate         # Activate (Windows)
deactivate                    # Deactivate virtual environment
```

### Code Quality Tools
```bash
pylint script.py             # Lint Python code
flake8 script.py             # Check style
black script.py               # Format code
mypy script.py                # Type checking
pytest                        # Run tests
pytest -v                     # Verbose test output
pytest -k test_name          # Run specific test
```

### Documentation
```bash
pydoc module                  # Show module documentation
python -m pydoc module        # Alternative
help(object)                  # Interactive help
```

## Common Python Operations

### File Operations
```python
# Read file
with open('file.txt', 'r') as f:
    content = f.read()

# Write file
with open('file.txt', 'w') as f:
    f.write('content')

# Read lines
with open('file.txt', 'r') as f:
    lines = f.readlines()
```

### String Operations
```python
# String methods
s.upper()                     # Convert to uppercase
s.lower()                     # Convert to lowercase
s.strip()                     # Remove whitespace
s.split(',')                  # Split string
','.join(list)                # Join list
s.replace('old', 'new')       # Replace substring
s.startswith('prefix')        # Check prefix
s.endswith('suffix')          # Check suffix
```

### List Operations
```python
# List methods
list.append(item)             # Add item
list.extend(iterable)         # Extend list
list.insert(index, item)      # Insert at index
list.remove(item)             # Remove item
list.pop(index)               # Remove and return item
list.sort()                   # Sort in place
sorted(list)                  # Return sorted copy
list.reverse()                # Reverse in place
list.count(item)              # Count occurrences
list.index(item)              # Find index
```

### Dictionary Operations
```python
# Dictionary methods
dict.keys()                   # Get keys
dict.values()                 # Get values
dict.items()                  # Get key-value pairs
dict.get(key, default)        # Get value with default
dict.update(other)            # Update dictionary
dict.pop(key)                 # Remove and return value
dict.clear()                  # Clear dictionary
```

## Python Scripting for DevOps

### System Operations
```python
import os
os.system('command')          # Execute shell command
os.getenv('VAR')              # Get environment variable
os.path.exists('path')        # Check if path exists
os.path.join('dir', 'file')   # Join paths
os.listdir('dir')             # List directory
os.makedirs('dir')            # Create directory
```

### Subprocess
```python
import subprocess
subprocess.run(['ls', '-l'])  # Run command
subprocess.check_output(['cmd'])  # Get output
subprocess.Popen(['cmd'])     # Run in background
```

### File System
```python
import shutil
shutil.copy('src', 'dst')     # Copy file
shutil.move('src', 'dst')     # Move file
shutil.rmtree('dir')          # Remove directory tree
```

### JSON
```python
import json
json.dumps(obj)               # Convert to JSON string
json.loads(string)            # Parse JSON string
json.dump(obj, file)          # Write to file
json.load(file)               # Read from file
```

### YAML
```python
import yaml
yaml.dump(obj, file)          # Write YAML
yaml.load(file)              # Read YAML
yaml.safe_load(file)         # Safe load
```

### HTTP Requests
```python
import requests
requests.get(url)             # GET request
requests.post(url, data)      # POST request
requests.put(url, data)       # PUT request
requests.delete(url)          # DELETE request
```

### Regular Expressions
```python
import re
re.search(pattern, string)    # Search pattern
re.match(pattern, string)     # Match at start
re.findall(pattern, string)   # Find all matches
re.sub(pattern, repl, string) # Substitute
```

## Best Practices

### Code Style
- Follow PEP 8 style guide
- Use meaningful variable names
- Write docstrings
- Keep functions small and focused
- Use type hints (Python 3.5+)

### Error Handling
```python
try:
    # Code
except Exception as e:
    # Handle error
finally:
    # Cleanup
```

### Logging
```python
import logging
logging.basicConfig(level=logging.INFO)
logging.info('Message')
logging.error('Error message')
```

