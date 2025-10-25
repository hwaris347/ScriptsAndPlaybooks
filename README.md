# Scripts and Playbooks

A collection of Ansible playbooks and Bash scripts for automating system configuration, deployment, and maintenance tasks.


## Ansible Playbooks

The `ansible/` directory contains playbooks for:
- System configuration and setup
- Package installation and management
- Service deployment
- Infrastructure automation

### Prerequisites
```bash
# Install Ansible
sudo pacman -S ansible  # Arch Linux
# or
sudo apt install ansible  # Debian/Ubuntu
```

### Usage
```bash
cd ansible/

# Run a playbook
ansible-playbook playbook-name.yml

# Run with inventory
ansible-playbook -i inventory.ini playbook-name.yml

# Dry run (check mode)
ansible-playbook playbook-name.yml --check

# Run specific tags
ansible-playbook playbook-name.yml --tags "tag1,tag2"
```

## Bash Scripts

The `scripts/` directory contains utility scripts for:
- System maintenance
- File operations
- Development workflows
- Custom automation tasks

### Usage
```bash
cd scripts/

# Make script executable
chmod +x script-name.sh

# Run script
./script-name.sh

# Or run directly with bash
bash script-name.sh
```

## Contributing

Feel free to fork and adapt these scripts and playbooks for your own use.

## Safety Notes

- Always review scripts before running them
- Test playbooks in a safe environment first
- Some scripts may require sudo/root privileges
- Back up important data before running system-modifying scripts

## License

MIT License - Feel free to use and modify as needed.

## Author

[Hwaris](https://github.com/hwaris347)

---

**Note**: This is a personal collection of automation tools. Use at your own discretion and always understand what a script does before executing it.
