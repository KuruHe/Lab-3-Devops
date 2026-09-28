# Part 1 - Ansible: Configure Infrastructure and Automate Application

## What this demonstrates
- Ansible inventory with a target node.
- Automated package installation.
- Application directory creation.
- Application deployment from a Jinja2 template.
- Nginx configuration and service management.
- Idempotent configuration using an Ansible playbook.

## Prerequisites
Ubuntu/Debian target node with:
- Python 3
- Ansible installed on the control machine
- sudo privileges on the target

## Run

```bash
cd 1_ansible
ansible --version
ansible-inventory -i inventory.ini --list
ansible-playbook -i inventory.ini site.yml --ask-become-pass
```

For a remote node, replace `localhost` in `inventory.ini` with:

```ini
[target_nodes]
target1 ansible_host=YOUR_SERVER_IP ansible_user=YOUR_USERNAME
```

Then test connectivity:

```bash
ansible -i inventory.ini target_nodes -m ping
```

Run the playbook:

```bash
ansible-playbook -i inventory.ini site.yml
```

## Verification

```bash
curl http://localhost
sudo systemctl status nginx --no-pager
```

For a remote node, use its IP instead of `localhost`.

## Evidence to capture
1. `ansible target_nodes -m ping`
2. Successful `ansible-playbook` output showing `changed`/`ok`.
3. Browser or `curl` output showing the Lab 3 page.
