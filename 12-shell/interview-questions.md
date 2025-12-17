# Shell Scripting Interview Questions

## Easy Level (Questions 1-35)

### 1. What is a shell?
A shell is a command-line interface that interprets user commands and executes them.

### 2. What are common Unix/Linux shells?
- Bash (Bourne Again Shell) - Most common
- sh (Bourne Shell)
- zsh (Z Shell)
- fish (Friendly Interactive Shell)
- csh/tcsh (C Shell)

### 3. What is a shell script?
A shell script is a file containing a series of shell commands executed sequentially.

### 4. What is a shebang?
A shebang (`#!/bin/bash`) is the first line of a script specifying the interpreter.

### 5. How do you make a script executable?
```bash
chmod +x script.sh
```

### 6. How do you run a shell script?
```bash
./script.sh
bash script.sh
sh script.sh
```

### 7. What is a variable?
A variable stores a value that can be referenced later.

### 8. How do you set a variable?
```bash
VAR="value"
```

### 9. How do you use a variable?
```bash
echo $VAR
echo ${VAR}
```

### 10. What are special variables?
- `$0`: Script name
- `$1, $2, ...`: Positional parameters
- `$#`: Number of arguments
- `$@`: All arguments
- `$?`: Exit status
- `$$`: Process ID

### 11. What is `$?`?
`$?` contains the exit status of the last command (0 = success, non-zero = error).

### 12. What is the difference between `$@` and `$*`?
- `$@`: All arguments as separate strings
- `$*`: All arguments as single string

### 13. What is an if statement?
An if statement conditionally executes commands based on a condition.

### 14. How do you write an if statement?
```bash
if [ condition ]; then
    commands
fi
```

### 15. What is a for loop?
A for loop repeats commands for each item in a list.

### 16. How do you write a for loop?
```bash
for i in 1 2 3; do
    echo $i
done
```

### 17. What is a while loop?
A while loop repeats commands while a condition is true.

### 18. How do you write a while loop?
```bash
while [ condition ]; do
    commands
done
```

### 19. What is a function?
A function is a named block of code that can be called multiple times.

### 20. How do you define a function?
```bash
function_name() {
    commands
}
```

### 21. What is `read`?
`read` reads input from the user or a file.

### 22. How do you read input?
```bash
read variable
read -p "Prompt: " variable
```

### 23. What is `echo`?
`echo` prints text to standard output.

### 24. What is `printf`?
`printf` prints formatted text.

### 25. What is redirection?
Redirection changes where input/output goes.

### 26. What are redirection operators?
- `>`: Redirect stdout (overwrite)
- `>>`: Redirect stdout (append)
- `<`: Redirect stdin
- `2>`: Redirect stderr
- `&>`: Redirect both

### 27. What is a pipe?
A pipe (`|`) sends output of one command as input to another.

### 28. What is `grep`?
`grep` searches for patterns in text.

### 29. How do you use grep?
```bash
grep "pattern" file.txt
grep -r "pattern" dir/
```

### 30. What is `sed`?
`sed` is a stream editor for filtering and transforming text.

### 31. How do you use sed?
```bash
sed 's/old/new/g' file.txt
sed -i 's/old/new/g' file.txt
```

### 32. What is `awk`?
`awk` is a text processing tool and programming language.

### 33. How do you use awk?
```bash
awk '{print $1}' file.txt
awk -F: '{print $1}' file.txt
```

### 34. What is `find`?
`find` searches for files and directories.

### 35. How do you use find?
```bash
find . -name "*.txt"
find . -type f -size +100M
```

## Medium Level (Questions 36-70)

### 36. What is `test` command?
`test` evaluates conditional expressions (also written as `[ ]`).

### 37. What are file test operators?
- `-f`: Regular file exists
- `-d`: Directory exists
- `-r`: File is readable
- `-w`: File is writable
- `-x`: File is executable
- `-s`: File is not empty

### 38. What are string test operators?
- `-z`: String is empty
- `-n`: String is not empty
- `=`: Strings are equal
- `!=`: Strings are not equal

### 39. What are numeric test operators?
- `-eq`: Equal
- `-ne`: Not equal
- `-lt`: Less than
- `-le`: Less than or equal
- `-gt`: Greater than
- `-ge`: Greater than or equal

### 40. What is `case` statement?
`case` matches a value against patterns.

### 41. How do you write a case statement?
```bash
case $var in
    pattern1)
        commands
        ;;
    pattern2)
        commands
        ;;
esac
```

### 42. What is `set`?
`set` controls shell options and positional parameters.

### 43. What is `set -e`?
`set -e` exits immediately if a command exits with non-zero status.

### 44. What is `set -u`?
`set -u` treats unset variables as an error.

### 45. What is `set -o pipefail`?
`set -o pipefail` returns exit status of last command in pipeline.

### 46. What is `trap`?
`trap` executes commands when signals are received.

### 47. How do you use trap?
```bash
trap 'cleanup' EXIT
trap 'echo "Interrupted"' INT
```

### 48. What is `local`?
`local` declares a variable local to a function.

### 49. What is `export`?
`export` makes a variable available to child processes.

### 50. What is `readonly`?
`readonly` makes a variable read-only.

### 51. What is an array?
An array stores multiple values.

### 52. How do you create an array?
```bash
arr=(item1 item2 item3)
```

### 53. How do you access array elements?
```bash
${arr[0]}        # First element
${arr[@]}        # All elements
${#arr[@]}       # Array length
```

### 54. What is string substitution?
String substitution manipulates strings using parameter expansion.

### 55. What are string substitution operators?
- `${var#pattern}`: Remove shortest prefix
- `${var##pattern}`: Remove longest prefix
- `${var%pattern}`: Remove shortest suffix
- `${var%%pattern}`: Remove longest suffix
- `${var/old/new}`: Replace first occurrence
- `${var//old/new}`: Replace all occurrences

### 56. What is arithmetic expansion?
Arithmetic expansion evaluates arithmetic expressions: `$((expression))`

### 57. What is `let`?
`let` evaluates arithmetic expressions.

### 58. What is `expr`?
`expr` evaluates expressions.

### 59. What is `here document`?
Here document redirects input from script: `<<EOF ... EOF`

### 60. What is `here string`?
Here string passes string as input: `<<<"string"`

### 61. What is `exec`?
`exec` replaces the shell process with a command.

### 62. What is `eval`?
`eval` evaluates arguments as shell commands.

### 63. What is `source` or `.`?
`source` executes a script in current shell (not subprocess).

### 64. What is `shift`?
`shift` shifts positional parameters left.

### 65. What is `getopts`?
`getopts` parses command-line options.

### 66. How do you use getopts?
```bash
while getopts "a:b:" opt; do
    case $opt in
        a) arg_a=$OPTARG ;;
        b) arg_b=$OPTARG ;;
    esac
done
```

### 67. What is `basename`?
`basename` extracts filename from path.

### 68. What is `dirname`?
`dirname` extracts directory from path.

### 69. What is `mktemp`?
`mktemp` creates temporary files or directories.

### 70. What is `trap` for cleanup?
`trap` can execute cleanup functions on script exit.

## High/Advanced Level (Questions 71-100)

### 71. What is process substitution?
Process substitution: `<(command)` or `>(command)`

### 72. What is `coproc`?
`coproc` creates a coprocess (Bash 4.0+).

### 73. What is `select`?
`select` creates a menu from a list.

### 74. What is `until` loop?
`until` loop repeats until condition is true (opposite of while).

### 75. What is `continue`?
`continue` skips remaining commands in loop iteration.

### 76. What is `break`?
`break` exits from a loop.

### 77. What is `return`?
`return` exits from a function with a status code.

### 78. What is `exit`?
`exit` terminates the script with a status code.

### 79. What is `wait`?
`wait` waits for background processes to complete.

### 80. What is `jobs`?
`jobs` lists active jobs.

### 81. What is `fg`?
`fg` brings a job to foreground.

### 82. What is `bg`?
`bg` sends a job to background.

### 83. What is `nohup`?
`nohup` runs a command immune to hangups.

### 84. What is `disown`?
`disown` removes a job from shell's job control.

### 85. What is `ulimit`?
`ulimit` controls resource limits.

### 86. What is `time`?
`time` measures execution time of a command.

### 87. What is `xargs`?
`xargs` builds and executes commands from stdin.

### 88. What is `parallel`?
`parallel` runs commands in parallel (GNU parallel).

### 89. What is `tee`?
`tee` reads from stdin and writes to stdout and files.

### 90. What is `sort`?
`sort` sorts lines of text.

### 91. What is `uniq`?
`uniq` removes duplicate lines.

### 92. What is `cut`?
`cut` extracts columns from text.

### 93. What is `paste`?
`paste` merges lines from files.

### 94. What is `join`?
`join` joins lines from two files.

### 95. What is `comm`?
`comm` compares two sorted files.

### 96. What is `diff`?
`diff` compares files line by line.

### 97. What is `patch`?
`patch` applies diff files.

### 98. What is `tar`?
`tar` archives files.

### 99. What is `rsync`?
`rsync` synchronizes files and directories.

### 100. What are shell scripting best practices?
- Use `set -euo pipefail` for error handling
- Quote variables to prevent word splitting
- Use `[[ ]]` instead of `[ ]` in Bash
- Use `readonly` for constants
- Use `local` in functions
- Check if files exist before operations
- Use meaningful variable names
- Add comments for complex logic
- Use functions for reusable code
- Handle errors gracefully
- Use `trap` for cleanup
- Validate input
- Use `getopts` for options
- Avoid hardcoded paths
- Use `$()` instead of backticks
- Prefer `printf` over `echo` for portability
- Use arrays for multiple values
- Test scripts thoroughly
- Follow POSIX when possible
- Document your scripts

