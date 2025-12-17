# Python Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Python?
Python is a high-level, interpreted programming language known for its simplicity and readability. It's widely used in DevOps, automation, web development, and data science.

### 2. What are the key features of Python?
- Simple and readable syntax
- Interpreted language
- Dynamically typed
- Object-oriented
- Extensive standard library
- Cross-platform

### 3. What is the difference between Python 2 and Python 3?
Python 3 is the current version with improved features, better Unicode support, and cleaner syntax. Python 2 is deprecated.

### 4. How do you run a Python script?
```bash
python script.py
python3 script.py
```

### 5. What is a variable in Python?
A variable is a name that refers to a value stored in memory.

### 6. What are Python data types?
- int: Integer
- float: Floating point
- str: String
- bool: Boolean
- list: List
- dict: Dictionary
- tuple: Tuple
- set: Set

### 7. What is the difference between a list and a tuple?
- List: Mutable, uses square brackets `[]`
- Tuple: Immutable, uses parentheses `()`

### 8. What is a dictionary?
A dictionary is a collection of key-value pairs, unordered and mutable.

### 9. How do you create a dictionary?
```python
dict = {'key': 'value'}
dict = dict(key='value')
```

### 10. What is a string?
A string is a sequence of characters enclosed in quotes.

### 11. What is string slicing?
String slicing extracts a portion of a string using indices: `string[start:end:step]`

### 12. What is a function?
A function is a block of reusable code that performs a specific task.

### 13. How do you define a function?
```python
def function_name(parameters):
    return value
```

### 14. What is the difference between `print()` and `return`?
- `print()`: Displays output to console
- `return`: Returns a value from a function

### 15. What is a module?
A module is a file containing Python code (functions, classes, variables).

### 16. How do you import a module?
```python
import module
from module import function
import module as alias
```

### 17. What is a package?
A package is a collection of modules organized in directories.

### 18. What is `if __name__ == "__main__"`?
It checks if the script is being run directly (not imported), allowing code to run only when executed as main.

### 19. What is a loop?
A loop repeats a block of code multiple times.

### 20. What are the types of loops in Python?
- `for` loop: Iterates over a sequence
- `while` loop: Repeats while condition is true

### 21. What is list comprehension?
List comprehension is a concise way to create lists: `[expression for item in iterable]`

### 22. What is a file operation?
File operations involve reading from or writing to files.

### 23. How do you read a file?
```python
with open('file.txt', 'r') as f:
    content = f.read()
```

### 24. How do you write to a file?
```python
with open('file.txt', 'w') as f:
    f.write('content')
```

### 25. What is exception handling?
Exception handling manages errors using `try`, `except`, `finally` blocks.

### 26. How do you handle exceptions?
```python
try:
    # code
except Exception as e:
    # handle error
finally:
    # cleanup
```

### 27. What is `pip`?
`pip` is the package installer for Python.

### 28. How do you install a package?
```bash
pip install package_name
```

### 29. What is a virtual environment?
A virtual environment is an isolated Python environment for project dependencies.

### 30. How do you create a virtual environment?
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows
```

### 31. What is `requirements.txt`?
`requirements.txt` lists project dependencies for easy installation.

### 32. What is a class?
A class is a blueprint for creating objects (instances).

### 33. What is an object?
An object is an instance of a class.

### 34. What is `self`?
`self` refers to the instance of the class in method definitions.

### 35. What is inheritance?
Inheritance allows a class to inherit attributes and methods from another class.

## Medium Level (Questions 36-70)

### 36. What is the difference between `==` and `is`?
- `==`: Compares values
- `is`: Compares object identity (memory location)

### 37. What is a generator?
A generator is a function that yields values one at a time, memory-efficient.

### 38. How do you create a generator?
```python
def generator():
    yield value
```

### 39. What is a decorator?
A decorator is a function that modifies another function's behavior.

### 40. What is `*args`?
`*args` allows a function to accept variable number of positional arguments.

### 41. What is `**kwargs`?
`**kwargs` allows a function to accept variable number of keyword arguments.

### 42. What is lambda?
Lambda is an anonymous function: `lambda x: x * 2`

### 43. What is a list vs set?
- List: Ordered, allows duplicates, mutable
- Set: Unordered, no duplicates, mutable

### 44. What is a tuple vs list?
- Tuple: Immutable, faster, uses `()`
- List: Mutable, uses `[]`

### 45. What is dictionary comprehension?
Dictionary comprehension creates dictionaries: `{k: v for k, v in iterable}`

### 46. What is `enumerate()`?
`enumerate()` adds counter to iterable: `enumerate(iterable, start=0)`

### 47. What is `zip()`?
`zip()` combines multiple iterables into tuples.

### 48. What is `map()`?
`map()` applies a function to all items in an iterable.

### 49. What is `filter()`?
`filter()` filters items from iterable based on condition.

### 50. What is `reduce()`?
`reduce()` applies a function cumulatively to items (from functools).

### 51. What is `os` module?
`os` module provides functions for interacting with the operating system.

### 52. What is `sys` module?
`sys` module provides access to Python interpreter variables and functions.

### 53. What is `subprocess` module?
`subprocess` module allows running shell commands from Python.

### 54. How do you run a shell command?
```python
import subprocess
subprocess.run(['ls', '-l'])
```

### 55. What is `json` module?
`json` module handles JSON data encoding and decoding.

### 56. What is `yaml` module?
`yaml` module handles YAML file parsing (requires PyYAML).

### 57. What is `requests` library?
`requests` library simplifies HTTP requests.

### 58. What is `logging` module?
`logging` module provides flexible logging functionality.

### 59. What is `argparse` module?
`argparse` module creates command-line interfaces.

### 60. What is `pathlib`?
`pathlib` provides object-oriented filesystem paths (Python 3.4+).

### 61. What is `collections` module?
`collections` module provides specialized container datatypes.

### 62. What is `defaultdict`?
`defaultdict` is a dictionary with default values for missing keys.

### 63. What is `Counter`?
`Counter` counts hashable objects (from collections).

### 64. What is `itertools`?
`itertools` provides iterator functions for efficient looping.

### 65. What is `functools`?
`functools` provides higher-order functions and operations on callable objects.

### 66. What is `contextlib`?
`contextlib` provides utilities for context managers.

### 67. What is a context manager?
A context manager manages resources using `with` statement.

### 68. What is `__init__`?
`__init__` is the constructor method that initializes an object.

### 69. What is `__str__`?
`__str__` returns string representation of an object.

### 70. What is `__repr__`?
`__repr__` returns official string representation of an object.

## High/Advanced Level (Questions 71-100)

### 71. What is a metaclass?
A metaclass is a class of a class, controlling class creation.

### 72. What is `__new__`?
`__new__` creates a new instance before `__init__` is called.

### 73. What is `__call__`?
`__call__` makes an instance callable like a function.

### 74. What is `__getattr__`?
`__getattr__` is called when attribute lookup fails.

### 75. What is `__setattr__`?
`__setattr__` is called when setting an attribute.

### 76. What is `__getitem__`?
`__getitem__` enables indexing: `obj[key]`

### 77. What is `__iter__`?
`__iter__` makes an object iterable.

### 78. What is `__enter__` and `__exit__`?
These methods implement context manager protocol.

### 79. What is `property`?
`property` creates managed attributes with getters/setters.

### 80. What is `staticmethod`?
`staticmethod` defines a method that doesn't require instance or class.

### 81. What is `classmethod`?
`classmethod` defines a method that receives class as first argument.

### 82. What is `@property` decorator?
`@property` converts a method into a read-only attribute.

### 83. What is `@staticmethod` decorator?
`@staticmethod` defines a static method.

### 84. What is `@classmethod` decorator?
`@classmethod` defines a class method.

### 85. What is multiple inheritance?
Multiple inheritance allows a class to inherit from multiple parent classes.

### 86. What is Method Resolution Order (MRO)?
MRO determines the order in which base classes are searched for methods.

### 87. What is `super()`?
`super()` calls methods from parent class.

### 88. What is `__slots__`?
`__slots__` restricts instance attributes, saving memory.

### 89. What is `__dict__`?
`__dict__` stores object's attributes as a dictionary.

### 90. What is `asyncio`?
`asyncio` provides asynchronous I/O and concurrency.

### 91. What is `async`/`await`?
`async`/`await` enables asynchronous programming.

### 92. What is `multiprocessing`?
`multiprocessing` enables parallel processing using multiple processes.

### 93. What is `threading`?
`threading` enables concurrent execution using threads.

### 94. What is GIL (Global Interpreter Lock)?
GIL is a mutex that allows only one thread to execute Python bytecode at a time.

### 95. What is `pickle`?
`pickle` serializes Python objects to byte streams.

### 96. What is `unittest`?
`unittest` is Python's built-in testing framework.

### 97. What is `pytest`?
`pytest` is a popular third-party testing framework.

### 98. What is `mock`?
`mock` (or `unittest.mock`) creates mock objects for testing.

### 99. What is `type hints`?
Type hints (Python 3.5+) specify expected types for variables and functions.

### 100. What are Python best practices for DevOps?
- Use virtual environments
- Follow PEP 8 style guide
- Write docstrings
- Use logging instead of print
- Handle exceptions properly
- Use `requirements.txt`
- Write unit tests
- Use type hints
- Follow DRY (Don't Repeat Yourself)
- Use context managers for resources
- Prefer list/dict comprehensions
- Use `pathlib` for file paths
- Use `subprocess` for shell commands
- Use `argparse` for CLI tools
- Document your code
- Use version control
- Write idempotent scripts
- Handle errors gracefully
- Use configuration files
- Follow security best practices

