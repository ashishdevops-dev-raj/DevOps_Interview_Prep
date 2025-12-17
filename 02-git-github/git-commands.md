# Git Commands Cheat Sheet

## Basic Commands

### Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --list                    # List all configurations
git config --global core.editor vim  # Set default editor
```

### Repository Setup
```bash
git init                            # Initialize new repository
git clone <url>                     # Clone remote repository
git clone <url> <directory>         # Clone into specific directory
git remote -v                       # List remote repositories
git remote add origin <url>         # Add remote repository
git remote remove <name>            # Remove remote
```

## Basic Workflow

### Staging and Committing
```bash
git status                          # Check repository status
git add <file>                      # Stage specific file
git add .                           # Stage all changes
git add -A                          # Stage all changes (including deletions)
git commit -m "message"             # Commit with message
git commit -am "message"            # Stage and commit (modified files only)
git commit --amend                  # Amend last commit
git commit --amend -m "new message" # Amend with new message
```

### Viewing Changes
```bash
git diff                            # Show unstaged changes
git diff --staged                   # Show staged changes
git diff HEAD                       # Show all changes
git log                             # View commit history
git log --oneline                   # Compact log view
git log --graph --oneline --all     # Visual log with branches
git show <commit>                   # Show commit details
```

## Branching

### Branch Operations
```bash
git branch                          # List all branches
git branch <name>                   # Create new branch
git branch -d <name>                # Delete branch (safe)
git branch -D <name>                # Force delete branch
git checkout <branch>               # Switch to branch
git checkout -b <branch>           # Create and switch to branch
git switch <branch>                 # Switch branch (newer syntax)
git switch -c <branch>              # Create and switch (newer syntax)
git merge <branch>                 # Merge branch into current
git merge --no-ff <branch>          # Merge with commit (no fast-forward)
```

### Branch Management
```bash
git branch -m <old> <new>           # Rename branch
git branch -a                       # List all branches (including remote)
git branch -r                       # List remote branches
```

## Remote Operations

### Fetch and Pull
```bash
git fetch                           # Fetch from remote
git fetch <remote>                  # Fetch from specific remote
git fetch --all                     # Fetch from all remotes
git pull                            # Fetch and merge
git pull --rebase                   # Fetch and rebase
```

### Push
```bash
git push                            # Push to remote
git push -u origin <branch>         # Push and set upstream
git push --force                    # Force push (dangerous!)
git push --force-with-lease         # Safer force push
git push --all                      # Push all branches
git push --tags                     # Push all tags
```

## Undoing Changes

### Reset
```bash
git reset                           # Unstage files (keep changes)
git reset --soft <commit>           # Reset to commit (keep changes staged)
git reset --mixed <commit>          # Reset to commit (unstage changes)
git reset --hard <commit>           # Reset to commit (discard changes)
git reset HEAD~1                    # Reset to previous commit
```

### Revert
```bash
git revert <commit>                 # Create new commit undoing changes
git revert HEAD                     # Revert last commit
```

### Checkout
```bash
git checkout -- <file>              # Discard changes in working directory
git checkout <commit>               # Checkout specific commit (detached HEAD)
```

## Stashing

```bash
git stash                           # Stash changes
git stash save "message"            # Stash with message
git stash list                      # List stashes
git stash apply                     # Apply last stash
git stash apply stash@{n}           # Apply specific stash
git stash pop                       # Apply and remove last stash
git stash drop                      # Delete last stash
git stash clear                     # Delete all stashes
```

## Tagging

```bash
git tag                             # List tags
git tag <name>                      # Create lightweight tag
git tag -a <name> -m "message"      # Create annotated tag
git tag -d <name>                   # Delete tag
git push origin <tag>               # Push specific tag
git push origin --tags              # Push all tags
```

## Advanced Commands

### Rebase
```bash
git rebase <branch>                 # Rebase current branch onto branch
git rebase -i <commit>              # Interactive rebase
git rebase --continue               # Continue after resolving conflicts
git rebase --abort                  # Abort rebase
```

### Cherry-pick
```bash
git cherry-pick <commit>           # Apply commit to current branch
git cherry-pick <commit1> <commit2> # Apply multiple commits
```

### Submodules
```bash
git submodule add <url> <path>     # Add submodule
git submodule init                  # Initialize submodules
git submodule update               # Update submodules
git submodule update --remote      # Update to latest remote
```

## Information and Inspection

```bash
git log --stat                      # Log with file statistics
git log --graph                     # Visual branch graph
git log --all --decorate --oneline --graph  # Full visual log
git blame <file>                    # Show who changed each line
git show <commit>:<file>            # Show file at specific commit
git ls-files                        # List tracked files
git ls-tree -r HEAD                 # List all files in tree
```

## Cleanup

```bash
git clean -n                        # Dry run (see what would be deleted)
git clean -f                        # Remove untracked files
git clean -fd                       # Remove untracked files and directories
git gc                              # Garbage collection
git prune                           # Remove unreachable objects
```

## Useful Aliases

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
```

## Common Workflows

### Feature Branch Workflow
```bash
git checkout -b feature/new-feature
# Make changes
git add .
git commit -m "Add new feature"
git push -u origin feature/new-feature
# Create pull request on GitHub
```

### Fixing Mistakes
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1

# Change last commit message
git commit --amend -m "New message"

# Add file to last commit
git add forgotten_file
git commit --amend --no-edit
```

