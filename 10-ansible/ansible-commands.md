# Ansible Commands Cheat Sheet

## Basic Commands

### Ad-Hoc Commands
```bash
ansible <hosts> -m <module> -a "<arguments>"
ansible all -m ping                    # Ping all hosts
ansible all -m command -a "uptime"     # Run command
ansible all -m shell -a "df -h"        # Run shell command
ansible all -m copy -a "src=file dest=/tmp/file"  # Copy file
ansible all -m file -a "path=/tmp/test state=directory"  # Create directory
```

### Playbook Execution
```bash
ansible-playbook playbook.yml          # Run playbook
ansible-playbook playbook.yml --check   # Dry run (check mode)
ansible-playbook playbook.yml --diff    # Show file differences
ansible-playbook playbook.yml -v       # Verbose output
ansible-playbook playbook.yml -vvv     # More verbose
ansible-playbook playbook.yml --limit <host>  # Limit to specific host
ansible-playbook playbook.yml --tags <tag>    # Run specific tags
ansible-playbook playbook.yml --skip-tags <tag>  # Skip tags
```

### Inventory
```bash
ansible-inventory --list               # List inventory
ansible-inventory --graph              # Show inventory graph
ansible-inventory --host <hostname>    # Show host variables
ansible all --list-hosts               # List all hosts
```

### Configuration
```bash
ansible-config view                    # View configuration
ansible-config dump                    # Dump configuration
ansible-config init                    # Initialize config file
```

### Vault
```bash
ansible-vault create file.yml          # Create encrypted file
ansible-vault edit file.yml            # Edit encrypted file
ansible-vault view file.yml            # View encrypted file
ansible-vault encrypt file.yml         # Encrypt existing file
ansible-vault decrypt file.yml         # Decrypt file
ansible-vault rekey file.yml           # Change vault password
ansible-playbook playbook.yml --ask-vault-pass  # Prompt for vault password
ansible-playbook playbook.yml --vault-password-file=file  # Use password file
```

### Galaxy
```bash
ansible-galaxy collection install <collection>  # Install collection
ansible-galaxy role install <role>     # Install role
ansible-galaxy init <role-name>        # Initialize new role
ansible-galaxy list                    # List installed roles
ansible-galaxy search <term>           # Search roles
ansible-galaxy info <role>             # Show role info
```

## Common Modules

### System
```bash
ansible all -m apt -a "name=nginx state=present"  # Install package (Debian/Ubuntu)
ansible all -m yum -a "name=nginx state=present"  # Install package (RHEL/CentOS)
ansible all -m service -a "name=nginx state=started"  # Start service
ansible all -m systemd -a "name=nginx state=started"  # Systemd service
ansible all -m user -a "name=john state=present"    # Create user
ansible all -m group -a "name=developers state=present"  # Create group
```

### Files
```bash
ansible all -m copy -a "src=file dest=/tmp/file mode=0644"  # Copy file
ansible all -m template -a "src=template.j2 dest=/tmp/file"  # Template
ansible all -m file -a "path=/tmp/dir state=directory"  # Create directory
ansible all -m file -a "path=/tmp/file state=absent"    # Delete file
ansible all -m synchronize -a "src=/local dest=/remote"  # Rsync
```

### Network
```bash
ansible all -m uri -a "url=http://example.com return_content=yes"  # HTTP request
ansible all -m get_url -a "url=http://example.com/file dest=/tmp/file"  # Download
```

### Cloud
```bash
ansible all -m ec2_instance -a "..."  # EC2 instance
ansible all -m ec2_ami -a "..."        # EC2 AMI
ansible all -m s3_bucket -a "..."      # S3 bucket
```

## Playbook Structure

### Basic Playbook
```yaml
---
- name: Playbook name
  hosts: all
  become: yes
  tasks:
    - name: Task name
      module_name:
        parameter: value
```

### With Variables
```yaml
---
- name: Playbook with variables
  hosts: all
  vars:
    package_name: nginx
  tasks:
    - name: Install package
      apt:
        name: "{{ package_name }}"
        state: present
```

### With Handlers
```yaml
---
- name: Playbook with handlers
  hosts: all
  tasks:
    - name: Configure service
      template:
        src: config.j2
        dest: /etc/service/config
      notify: restart service
  
  handlers:
    - name: restart service
      service:
        name: service
        state: restarted
```

## Inventory Files

### INI Format
```ini
[webservers]
web1 ansible_host=192.168.1.10
web2 ansible_host=192.168.1.11

[databases]
db1 ansible_host=192.168.1.20

[webservers:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

### YAML Format
```yaml
all:
  children:
    webservers:
      hosts:
        web1:
          ansible_host: 192.168.1.10
        web2:
          ansible_host: 192.168.1.11
      vars:
        ansible_user: ubuntu
    databases:
      hosts:
        db1:
          ansible_host: 192.168.1.20
```

## Best Practices

### File Organization
```
.
├── playbooks/
│   ├── site.yml
│   ├── webservers.yml
│   └── databases.yml
├── roles/
│   ├── nginx/
│   └── mysql/
├── inventory/
│   ├── production
│   └── staging
├── group_vars/
│   ├── all.yml
│   └── webservers.yml
├── host_vars/
│   └── web1.yml
└── ansible.cfg
```

### ansible.cfg
```ini
[defaults]
inventory = inventory/production
remote_user = ubuntu
private_key_file = ~/.ssh/id_rsa
host_key_checking = False
retry_files_enabled = False
roles_path = roles
collections_path = collections
```

### Common Options
```bash
--become, -b                    # Become root
--become-user=USER, -b USER     # Become specific user
--ask-become-pass, -K           # Ask for become password
--ask-pass, -k                   # Ask for SSH password
--private-key=FILE, --key-file=FILE  # SSH private key
--user=USER, -u USER             # Remote user
--forks=N                        # Number of parallel processes
--timeout=N                      # SSH timeout
```

