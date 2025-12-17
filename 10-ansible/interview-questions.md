# Ansible Interview Questions

## Easy Level (Questions 1-35)

### 1. What is Ansible?
Ansible is an open-source automation tool for configuration management, application deployment, and task automation.

### 2. What is configuration management?
Configuration management is the process of maintaining computer systems, servers, and software in a desired, consistent state.

### 3. What are the main components of Ansible?
- Control Node (where Ansible runs)
- Managed Nodes (target systems)
- Inventory (list of managed nodes)
- Playbooks (automation scripts)
- Modules (units of work)

### 4. What is an Ansible playbook?
A playbook is a YAML file containing a series of tasks to be executed on managed nodes.

### 5. What is an Ansible module?
A module is a discrete unit of code that Ansible executes (e.g., `apt`, `yum`, `copy`, `service`).

### 6. What is an inventory?
An inventory is a file that lists the hosts and groups of hosts that Ansible manages.

### 7. How do you run an ad-hoc command?
```bash
ansible all -m ping
ansible all -m command -a "uptime"
```

### 8. How do you run a playbook?
```bash
ansible-playbook playbook.yml
```

### 9. What is `ansible.cfg`?
`ansible.cfg` is the configuration file for Ansible that sets defaults and behavior.

### 10. What is a task?
A task is a single action to be performed on a managed node (e.g., install a package, start a service).

### 11. What is a play?
A play is a set of tasks to be executed on a set of hosts.

### 12. What is a handler?
A handler is a special task that runs only when notified by another task.

### 13. How do you define a handler?
```yaml
handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
```

### 14. How do you trigger a handler?
```yaml
tasks:
  - name: Configure nginx
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    notify: restart nginx
```

### 15. What is a variable in Ansible?
A variable stores a value that can be used throughout your playbooks.

### 16. How do you define a variable?
```yaml
vars:
  package_name: nginx
```

### 17. How do you use a variable?
```yaml
- name: Install package
  apt:
    name: "{{ package_name }}"
```

### 18. What is `ansible-vault`?
`ansible-vault` encrypts sensitive data like passwords and API keys.

### 19. How do you create an encrypted file?
```bash
ansible-vault create secrets.yml
```

### 20. How do you edit an encrypted file?
```bash
ansible-vault edit secrets.yml
```

### 21. What is an Ansible role?
A role is a collection of tasks, variables, files, templates, and handlers organized in a directory structure.

### 22. What is `ansible-galaxy`?
`ansible-galaxy` is a command-line tool for managing Ansible roles and collections.

### 23. How do you install a role?
```bash
ansible-galaxy role install username.role_name
```

### 24. What is a collection?
A collection is a distribution format for Ansible content (roles, modules, plugins).

### 25. How do you install a collection?
```bash
ansible-galaxy collection install namespace.collection_name
```

### 26. What is `become`?
`become` allows you to execute tasks with elevated privileges (like sudo).

### 27. How do you use `become`?
```yaml
- name: Install package
  apt:
    name: nginx
  become: yes
```

### 28. What is `ansible-playbook --check`?
`--check` runs the playbook in check mode (dry run) without making changes.

### 29. What is `ansible-playbook --diff`?
`--diff` shows file differences when files are changed.

### 30. What is `ansible-playbook --limit`?
`--limit` restricts execution to specific hosts or groups.

### 31. What is `ansible-playbook --tags`?
`--tags` runs only tasks with specified tags.

### 32. What is `ansible-playbook --skip-tags`?
`--skip-tags` skips tasks with specified tags.

### 33. What is a fact?
A fact is a variable that Ansible automatically discovers about a system.

### 34. How do you display facts?
```bash
ansible hostname -m setup
```

### 35. What is `gather_facts`?
`gather_facts` controls whether Ansible collects facts about managed nodes (default: yes).

## Medium Level (Questions 36-70)

### 36. What is an inventory plugin?
An inventory plugin allows Ansible to dynamically generate inventory from various sources (cloud providers, databases, etc.).

### 37. What is a dynamic inventory?
A dynamic inventory is generated programmatically rather than from a static file.

### 38. What is `ansible-inventory`?
`ansible-inventory` displays or dumps the configured inventory.

### 39. What is a group variable?
A group variable is a variable applied to all hosts in a group.

### 40. Where do you define group variables?
In `group_vars/<group_name>.yml` or in the inventory file.

### 41. What is a host variable?
A host variable is a variable specific to a single host.

### 42. Where do you define host variables?
In `host_vars/<hostname>.yml` or in the inventory file.

### 43. What is a template?
A template is a file with variables that Ansible renders before copying to the managed node.

### 44. What template engine does Ansible use?
Ansible uses Jinja2 templating engine.

### 45. How do you use a template?
```yaml
- name: Configure nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
```

### 46. What is a loop?
A loop allows you to repeat a task multiple times with different values.

### 47. How do you use a loop?
```yaml
- name: Install packages
  apt:
    name: "{{ item }}"
  loop:
    - nginx
    - mysql
    - php
```

### 48. What is `when`?
`when` conditionally executes a task based on a condition.

### 49. How do you use `when`?
```yaml
- name: Install package
  apt:
    name: nginx
  when: ansible_os_family == "Debian"
```

### 50. What is `register`?
`register` stores the result of a task in a variable.

### 51. How do you use `register`?
```yaml
- name: Check if service is running
  command: systemctl is-active nginx
  register: nginx_status

- name: Display status
  debug:
    msg: "Nginx is {{ nginx_status.stdout }}"
```

### 52. What is `failed_when`?
`failed_when` allows you to define when a task should be considered failed.

### 53. What is `changed_when`?
`changed_when` allows you to define when a task should be considered changed.

### 54. What is `ignore_errors`?
`ignore_errors` allows a task to continue even if it fails.

### 55. What is a block?
A block groups tasks together and allows error handling.

### 56. How do you use a block?
```yaml
- block:
    - name: Task 1
      command: /bin/false
    - name: Task 2
      command: /bin/true
  rescue:
    - name: Handle error
      debug:
        msg: "An error occurred"
```

### 57. What is `rescue`?
`rescue` defines tasks to run when a block fails.

### 58. What is `always`?
`always` defines tasks that always run, regardless of success or failure.

### 59. What is `pre_tasks`?
`pre_tasks` are tasks that run before the main tasks in a play.

### 60. What is `post_tasks`?
`post_tasks` are tasks that run after the main tasks in a play.

### 61. What is `serial`?
`serial` limits the number of hosts a play runs on simultaneously.

### 62. How do you use `serial`?
```yaml
- hosts: webservers
  serial: 2
  tasks:
    - name: Deploy application
      # ...
```

### 63. What is `strategy`?
`strategy` controls how Ansible executes tasks on multiple hosts.

### 64. What are the available strategies?
- `linear`: Default, one host at a time
- `free`: All hosts in parallel
- `host_pinned`: Custom parallelization

### 65. What is `delegate_to`?
`delegate_to` runs a task on a different host than the play's target.

### 66. What is `run_once`?
`run_once` runs a task only once, even if multiple hosts are targeted.

### 67. What is `local_action`?
`local_action` runs a task on the control node instead of managed nodes.

### 68. What is `ansible-pull`?
`ansible-pull` runs playbooks locally by pulling them from a repository.

### 69. What is `ansible-console`?
`ansible-console` provides an interactive REPL for executing ad-hoc tasks.

### 70. What is `ansible-doc`?
`ansible-doc` displays documentation for modules and plugins.

## High/Advanced Level (Questions 71-100)

### 71. What is an Ansible callback plugin?
A callback plugin controls the output and behavior of Ansible execution.

### 72. What is `ansible-lint`?
`ansible-lint` is a tool that checks playbooks for best practices and potential issues.

### 73. What is `molecule`?
Molecule is a testing framework for Ansible roles.

### 74. What is `ansible-builder`?
`ansible-builder` creates execution environments for Ansible Automation Platform.

### 75. What is an execution environment?
An execution environment is a container image containing Ansible and its dependencies.

### 76. What is `ansible-navigator`?
`ansible-navigator` is a command-line tool for running Ansible Automation Platform content.

### 77. What is Ansible Tower/AWX?
Ansible Tower (commercial) and AWX (open-source) provide a web-based UI and API for Ansible.

### 78. What is a custom module?
A custom module is a module you write to perform specific tasks not covered by built-in modules.

### 79. What is a filter plugin?
A filter plugin extends Jinja2 templating with custom filters.

### 80. What is a lookup plugin?
A lookup plugin retrieves data from external sources (files, databases, APIs).

### 81. What is `vault_password_file`?
`vault_password_file` specifies a file containing the vault password.

### 82. What is `ansible-vault rekey`?
`ansible-vault rekey` changes the password of an encrypted file.

### 83. What is `ansible-vault view`?
`ansible-vault view` displays the contents of an encrypted file without editing.

### 84. What is `ansible-playbook --vault-password-file`?
`--vault-password-file` specifies a file containing the vault password.

### 85. What is `ansible-playbook --ask-vault-pass`?
`--ask-vault-pass` prompts for the vault password.

### 86. What is `host_key_checking`?
`host_key_checking` controls whether Ansible verifies SSH host keys.

### 87. What is `pipelining`?
`pipelining` reduces the number of SSH operations by piping scripts through SSH.

### 88. What is `forks`?
`forks` controls the number of parallel processes Ansible uses.

### 89. What is `gathering`?
`gathering` controls when Ansible gathers facts (implicit, explicit, smart, or never).

### 90. What is fact caching?
Fact caching stores facts in a cache to avoid re-gathering them on every run.

### 91. How do you enable fact caching?
```ini
[defaults]
fact_caching = jsonfile
fact_caching_connection = /tmp/ansible_facts
```

### 92. What is `ansible-playbook --list-tasks`?
`--list-tasks` lists all tasks that would be executed.

### 93. What is `ansible-playbook --list-hosts`?
`--list-hosts` lists all hosts that would be affected.

### 94. What is `ansible-playbook --syntax-check`?
`--syntax-check` checks playbook syntax without executing.

### 95. What is `ansible-playbook --start-at-task`?
`--start-at-task` starts execution at a specific task.

### 96. What is `ansible-playbook --step`?
`--step` prompts before executing each task.

### 97. What is `ansible-config`?
`ansible-config` manages Ansible configuration files.

### 98. What is `ansible-config view`?
`ansible-config view` displays the current configuration.

### 99. What is `ansible-config dump`?
`ansible-config dump` shows all configuration settings.

### 100. What are Ansible best practices?
- Use roles for reusability
- Use variables for flexibility
- Use handlers for service restarts
- Use tags for selective execution
- Use vault for secrets
- Use inventory organization
- Use meaningful task names
- Use `--check` before applying
- Use version control
- Use `ansible-lint` for quality
- Use `gather_facts: false` when not needed
- Use `serial` for rolling updates
- Use `delegate_to` for orchestration
- Use `run_once` for singleton tasks
- Document your playbooks
- Use consistent naming conventions
- Test in development first
- Use idempotent tasks
- Avoid using `command` and `shell` when modules exist
- Use `changed_when` and `failed_when` appropriately

