# Git & GitHub Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Git?
Git is a distributed version control system that tracks changes in source code during software development. It allows multiple developers to work on the same project simultaneously.

### 2. What is the difference between Git and GitHub?
- **Git**: Version control system (software)
- **GitHub**: Cloud-based hosting service for Git repositories with additional features like pull requests, issues, and project management

### 3. What is a repository?
A repository (repo) is a directory that contains your project files and the entire history of changes. It's tracked by Git.

### 4. How do you initialize a Git repository?
```bash
git init
```

### 5. How do you clone a repository?
```bash
git clone <url>
git clone <url> <directory>
```

### 6. Explain the three states of a file in Git.
1. **Modified**: File has been changed but not staged
2. **Staged**: File is marked to be included in the next commit
3. **Committed**: File is safely stored in the local database

### 7. How do you check the status of your repository?
```bash
git status
```

### 8. How do you stage files?
```bash
git add <file>
git add .
git add -A
```

### 9. What is the difference between `git add .` and `git add -A`?
- `git add .`: Stages files in current directory and subdirectories
- `git add -A`: Stages all changes in the entire repository (including deletions)

### 10. How do you commit changes?
```bash
git commit -m "message"
git commit -am "message"  # Stage and commit (modified files only)
```

### 11. What is a commit?
A commit is a snapshot of your repository at a specific point in time. It includes:
- A unique hash (SHA-1)
- Author information
- Commit message
- Reference to parent commit(s)

### 12. How do you view commit history?
```bash
git log
git log --oneline
git log --graph --oneline --all
```

### 13. How do you see what changed in a commit?
```bash
git show <commit>
git diff
git diff --staged
```

### 14. What is a branch?
A branch is a movable pointer to a commit. It allows you to work on different features or versions of your code independently.

### 15. How do you create a branch?
```bash
git branch <name>
git checkout -b <name>
git switch -c <name>
```

### 16. How do you switch branches?
```bash
git checkout <branch>
git switch <branch>
```

### 17. How do you list branches?
```bash
git branch
git branch -a  # All branches including remote
git branch -r  # Remote branches only
```

### 18. How do you delete a branch?
```bash
git branch -d <name>  # Safe delete
git branch -D <name>  # Force delete
```

### 19. What is a remote?
A remote is a reference to another repository, typically on a server like GitHub. Common remote name is "origin".

### 20. How do you add a remote?
```bash
git remote add origin <url>
```

### 21. How do you view remotes?
```bash
git remote -v
```

### 22. How do you push to remote?
```bash
git push
git push -u origin <branch>  # Push and set upstream
```

### 23. How do you pull from remote?
```bash
git pull
git fetch
```

### 24. What is the difference between `git pull` and `git fetch`?
- `git fetch`: Downloads changes from remote but doesn't merge them
- `git pull`: Downloads changes and automatically merges them into current branch (fetch + merge)

### 25. What is `.gitignore`?
`.gitignore` is a file that specifies which files Git should ignore (not track). Common entries:
```
*.log
node_modules/
.env
.DS_Store
```

### 26. What is a merge?
A merge combines changes from different branches into one branch.

### 27. How do you merge branches?
```bash
git merge <branch>
```

### 28. What is a merge conflict?
A merge conflict occurs when Git cannot automatically merge changes. Happens when:
- Same lines changed in different branches
- One branch deleted a file, other modified it

### 29. How do you resolve a merge conflict?
1. Identify conflicted files (`git status`)
2. Open files and look for conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Edit to resolve conflicts
4. Stage resolved files (`git add`)
5. Complete merge (`git commit`)

### 30. What is a Pull Request (PR)?
A Pull Request is a GitHub feature that proposes changes to a repository. It allows code review and discussion before merging.

### 31. What is a fork?
A fork is a copy of a repository that you own. Allows you to make changes without affecting the original repository.

### 32. Explain the difference between fork and clone.
- **Fork**: Creates a copy on GitHub (server-side)
- **Clone**: Downloads repository to local machine

### 33. What is the difference between `main` and `master`?
Both are default branch names. `master` was traditional, `main` is now preferred for inclusivity.

### 34. How do you rename a branch?
```bash
git branch -m <old> <new>
```

### 35. How do you see which branch you're on?
```bash
git branch
git status
```

## Medium Level (Questions 36-70)

### 36. Explain the basic Git workflow.
1. Modify files in working directory
2. Stage changes (`git add`)
3. Commit changes (`git commit`)
4. Push to remote (`git push`)

### 37. What is the staging area (index)?
The staging area is an intermediate area where you prepare changes before committing. It allows you to selectively choose what to commit.

### 38. What is the difference between `git checkout` and `git switch`?
- `git checkout`: Older command that can switch branches or restore files
- `git switch`: Newer, dedicated command for switching branches (Git 2.23+)

### 39. Explain the difference between `git merge` and `git rebase`.
- **Merge**: Creates a merge commit combining two branches, preserving history
- **Rebase**: Moves commits from one branch onto another, creating a linear history

### 40. What is a fast-forward merge?
A fast-forward merge occurs when the target branch hasn't diverged from the source branch. Git simply moves the pointer forward.

### 41. How do you perform a rebase?
```bash
git rebase <branch>
git rebase -i <commit>  # Interactive rebase
```

### 42. What is the difference between `git rebase` and `git merge`?
- **Rebase**: Creates linear history, rewrites commit history
- **Merge**: Preserves branch history, creates merge commit

### 43. When should you use `git rebase` vs `git merge`?
- **Rebase**: For cleaner history, feature branches (before merging)
- **Merge**: For shared/public branches, preserving exact history

### 44. How do you amend a commit?
```bash
git commit --amend -m "New message"
```
This modifies the last commit. Use with caution if already pushed.

### 45. How do you add a file to the last commit?
```bash
git add forgotten_file
git commit --amend --no-edit
```

### 46. Explain the difference between `git reset` and `git revert`.
- `git reset`: Moves the branch pointer backward (rewrites history)
- `git revert`: Creates a new commit that undoes changes (preserves history)

### 47. What are the three types of `git reset`?
- `--soft`: Moves HEAD, keeps changes staged
- `--mixed` (default): Moves HEAD, unstages changes, keeps in working directory
- `--hard`: Moves HEAD, discards all changes

### 48. How do you discard local changes?
```bash
git checkout -- <file>    # Discard changes in file
git reset --hard HEAD     # Discard all changes
```

### 49. What is `git stash`?
`git stash` temporarily saves uncommitted changes so you can work on something else, then reapply them later.

### 50. How do you use git stash?
```bash
git stash
git stash save "message"
git stash list
git stash apply
git stash pop
git stash drop
```

### 51. What is the difference between `git stash apply` and `git stash pop`?
- `git stash apply`: Applies stash but keeps it in stash list
- `git stash pop`: Applies stash and removes it from stash list

### 52. Explain the difference between `git push --force` and `git push --force-with-lease`.
- `--force`: Overwrites remote branch regardless of its state (dangerous)
- `--force-with-lease`: Only overwrites if remote hasn't changed (safer)

### 53. What is the upstream branch?
The upstream branch is the remote branch that your local branch tracks. Set with `git push -u origin <branch>`.

### 54. How do you set upstream branch?
```bash
git push -u origin <branch>
git branch --set-upstream-to=origin/<branch> <branch>
```

### 55. What is a tag?
A tag is a reference to a specific commit, often used for releases.

### 56. How do you create a tag?
```bash
git tag <name>                    # Lightweight tag
git tag -a <name> -m "message"    # Annotated tag
```

### 57. How do you push tags?
```bash
git push origin <tag>
git push --tags
```

### 58. What is a detached HEAD state?
When you checkout a specific commit instead of a branch, you're in a detached HEAD state. Changes won't be associated with any branch.

### 59. How do you get out of detached HEAD?
```bash
git checkout <branch>
git checkout -b <new-branch>
```

### 60. What is `git cherry-pick`?
`git cherry-pick` applies a specific commit from one branch to another branch.

### 61. How do you cherry-pick a commit?
```bash
git cherry-pick <commit>
git cherry-pick <commit1> <commit2>
```

### 62. Explain Git rebase interactively.
Interactive rebase (`git rebase -i`) allows you to:
- Edit commits
- Combine commits (squash)
- Reorder commits
- Remove commits

### 63. What is a submodule?
A submodule is a Git repository inside another Git repository. Useful for including external dependencies.

### 64. How do you work with submodules?
```bash
git submodule add <url> <path>
git submodule init
git submodule update
```

### 65. What makes a good commit message?
- Clear and descriptive
- Present tense ("Add feature" not "Added feature")
- First line < 50 characters
- Body explains what and why

### 66. What is a good branching strategy?
Common strategies:
- **Git Flow**: `main`, `develop`, `feature/*`, `release/*`, `hotfix/*`
- **GitHub Flow**: `main` and feature branches
- **Trunk-based**: Single branch with frequent commits

### 67. How do you view differences between branches?
```bash
git diff <branch1> <branch2>
git diff main..feature
```

### 68. How do you find which commit changed a file?
```bash
git log -- <file>
git log -p -- <file>
```

### 69. How do you see who changed a line?
```bash
git blame <file>
```

### 70. What is `git reflog`?
`reflog` shows a log of where your HEAD and branch references have been. Useful for recovering "lost" commits.

## High/Advanced Level (Questions 71-100)

### 71. How do you recover a deleted branch?
```bash
git reflog            # Find the commit hash
git checkout -b <branch> <commit-hash>
```

### 72. How do you find which commit introduced a bug?
```bash
git bisect start
git bisect bad        # Mark current commit as bad
git bisect good <commit>  # Mark known good commit
# Git will help you narrow down the problematic commit
```

### 73. What is `git bisect`?
`git bisect` uses binary search to find the commit that introduced a bug.

### 74. How do you remove a file from Git but keep it locally?
```bash
git rm --cached <file>
```

### 75. How do you remove a file from Git and delete it?
```bash
git rm <file>
```

### 76. What is `git clean`?
`git clean` removes untracked files from the working directory.

### 77. How do you use git clean?
```bash
git clean -n         # Dry run
git clean -f         # Remove untracked files
git clean -fd        # Remove untracked files and directories
```

### 78. What is `git worktree`?
`git worktree` allows you to have multiple working directories for the same repository.

### 79. How do you create a worktree?
```bash
git worktree add <path> <branch>
```

### 80. What is `git filter-branch`?
`git filter-branch` rewrites Git history, useful for removing sensitive data or changing file structure.

### 81. What is `git filter-repo`?
`git filter-repo` is a modern replacement for `filter-branch`, faster and safer.

### 82. How do you change the author of commits?
```bash
git commit --amend --author="Name <email>"
# Or for multiple commits
git rebase -i <commit> --exec 'git commit --amend --author="Name <email>" --no-edit'
```

### 83. What is `git hooks`?
Git hooks are scripts that run automatically at certain points in the Git workflow.

### 84. Where are Git hooks stored?
`.git/hooks/` directory in the repository.

### 85. What are common Git hooks?
- `pre-commit`: Before commit
- `post-commit`: After commit
- `pre-push`: Before push
- `commit-msg`: Validate commit message

### 86. What is `git config`?
`git config` sets and reads Git configuration values.

### 87. How do you configure Git?
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --list
```

### 88. What is `git alias`?
Git aliases allow you to create shortcuts for Git commands.

### 89. How do you create a Git alias?
```bash
git config --global alias.st status
git config --global alias.co checkout
```

### 90. What is `git bundle`?
`git bundle` packages a repository into a single file for transfer.

### 91. How do you create a bundle?
```bash
git bundle create repo.bundle HEAD master
```

### 92. What is `git archive`?
`git archive` creates an archive of files from a named tree.

### 93. How do you create an archive?
```bash
git archive --format=tar --output=archive.tar HEAD
```

### 94. What is `git notes`?
`git notes` adds notes to commits without modifying the commit itself.

### 95. How do you add notes to a commit?
```bash
git notes add -m "Note text" <commit>
```

### 96. What is `git replace`?
`git replace` allows you to replace one object with another without modifying history.

### 97. What is shallow clone?
A shallow clone limits the history depth, useful for large repositories.

### 98. How do you create a shallow clone?
```bash
git clone --depth 1 <url>
```

### 99. What is `git sparse-checkout`?
`git sparse-checkout` allows you to work with a subset of files in a large repository.

### 100. How do you use sparse-checkout?
```bash
git sparse-checkout init
git sparse-checkout set <dir>
```
