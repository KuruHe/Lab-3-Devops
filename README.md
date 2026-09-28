# 🚀 Lab 3 – Monitoring, Logging & DevSecOps

This repository contains the implementation for **Lab 3: Monitoring, Logging & DevSecOps**, focusing on infrastructure automation, configuration management, and Infrastructure as Code (IaC).

The lab is divided into two major tasks:

- **Ansible** – Configure infrastructure and automate application deployment.
- **Terraform** – Provision scalable infrastructure using Docker containers.

---

## 📌 Lab Objectives

The main objectives of this lab are to:

- Automate infrastructure configuration using **Ansible**.
- Deploy and configure a web application automatically.
- Manage services using Ansible playbooks.
- Use **Terraform** for Infrastructure as Code.
- Provision containerized infrastructure using **Docker**.
- Demonstrate scalable infrastructure using Terraform variables.
- Verify and test the deployed infrastructure.

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| 🐧 Ubuntu / WSL | Linux execution environment |
| ⚙️ Ansible | Configuration management & automation |
| 🏗️ Terraform | Infrastructure as Code |
| 🐳 Docker | Containerized infrastructure |
| 🌐 Nginx | Web server |
| 📝 YAML | Ansible configuration |
| 🔧 HCL | Terraform configuration |
| 🔀 Git & GitHub | Version control |

---

# 📂 Project Structure

```text
Lab-3-Devops/
│
├── Lab3_Ansible_Submission/
│   └── Lab3_Ansible/
│       ├── README.md
│       ├── inventory.ini
│       ├── site.yml
│       └── templates/
│           └── index.html.j2
│
├── Lab3_Terraform_Submission/
│   └── Lab3_Terraform/
│       ├── README.md
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars.example
│       └── .terraform.lock.hcl
│
└── README.md
```

> `.terraform/` generated files are intentionally excluded from version control.

---

# 1️⃣ Ansible – Infrastructure & Application Automation

The Ansible section automates the configuration of a local Ubuntu target node.

### 🔹 What the Playbook Does

The Ansible playbook:

1. Gathers system information.
2. Installs Nginx.
3. Creates the application directory.
4. Deploys the web application using a Jinja2 template.
5. Configures the Nginx virtual host.
6. Enables the Lab 3 site.
7. Removes the default Nginx site.
8. Ensures Nginx is enabled and running.
9. Restarts Nginx when configuration changes occur.

### 📁 Ansible Files

```text
Lab3_Ansible/
├── inventory.ini
├── site.yml
└── templates/
    └── index.html.j2
```

---

## ⚙️ Ansible Inventory

The target node is configured as localhost:

```ini
[target_nodes]
localhost ansible_connection=local
```

---

## ▶️ Run Ansible

Navigate to the Ansible directory:

```bash
cd Lab3_Ansible_Submission/Lab3_Ansible
```

Check Ansible:

```bash
ansible --version
```

Test connectivity:

```bash
ansible -i inventory.ini target_nodes -m ping
```

Run the playbook:

```bash
ansible-playbook -i inventory.ini site.yml
```

---

## 🌐 Verify the Application

After the playbook finishes:

```bash
curl http://localhost
```

The deployed application should display:

```text
Lab 3: Ansible Configuration Successful
```

You can also verify Nginx:

```bash
sudo systemctl status nginx --no-pager
```

Expected state:

```text
Active: active (running)
```

---

# 2️⃣ Terraform – Provision Scalable Infrastructure

The Terraform section demonstrates **Infrastructure as Code** by provisioning Nginx web servers as Docker containers.

Terraform manages:

- Docker provider
- Nginx Docker image
- Docker containers
- Container ports
- Instance count
- Project naming
- Terraform outputs

---

## 📁 Terraform Files

```text
Lab3_Terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── .terraform.lock.hcl
```

---

## ⚙️ Terraform Configuration

The infrastructure uses Terraform's `count` mechanism to control the number of web instances.

Example:

```hcl
resource "docker_container" "web" {
  count = var.instance_count

  name  = "${var.project_name}-web-${count.index + 1}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.base_port + count.index
  }
}
```

This allows the infrastructure to be scaled without manually creating individual containers.

---

# 🚀 Terraform Setup

Navigate to the Terraform directory:

```bash
cd Lab3_Terraform_Submission/Lab3_Terraform
```

Check Terraform:

```bash
terraform --version
```

Check Docker:

```bash
docker --version
```

Make sure Docker is running before continuing.

---

## 1. Initialize Terraform

```bash
terraform init
```

---

## 2. Format Configuration

```bash
terraform fmt
```

---

## 3. Validate Configuration

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

## 4. Preview Infrastructure

```bash
terraform plan
```

Review the resources Terraform intends to create.

---

## 5. Provision Infrastructure

```bash
terraform apply
```

Enter:

```text
yes
```

when Terraform asks for confirmation.

---

# 🔍 Verify Infrastructure

View Terraform outputs:

```bash
terraform output
```

View running Docker containers:

```bash
docker ps
```

The Nginx containers should be running and mapped to different host ports.

For example:

```text
localhost:8081
localhost:8082
```

Open them in a browser to verify the web server.

---

# 📈 Scaling the Infrastructure

The infrastructure can be scaled by changing the number of instances.

For example, to provision **3 Nginx instances**:

```bash
terraform apply -var="instance_count=3"
```

Terraform will create the additional instance automatically.

The containers can then be accessed through:

```text
http://localhost:8081
http://localhost:8082
http://localhost:8083
```

This demonstrates how Infrastructure as Code can be used to manage scalable infrastructure declaratively.

---

# 🧹 Cleanup

After completing the lab, Terraform resources can be removed with:

```bash
terraform destroy
```

Confirm with:

```text
yes
```

---

# ✅ Verification Checklist

### Ansible

- [x] Ansible installed
- [x] Inventory configured
- [x] Target node reachable
- [x] Nginx installed
- [x] Application deployed
- [x] Nginx configured
- [x] Application verified using `curl`
- [x] Nginx service verified

### Terraform

- [x] Terraform initialized
- [x] Docker provider configured
- [x] Configuration formatted
- [x] Configuration validated
- [x] Terraform plan generated
- [x] Infrastructure provisioned
- [x] Docker containers verified
- [x] Application accessed through browser
- [x] Infrastructure scaling demonstrated

---

# 🎯 Lab Outcome

This lab demonstrates practical DevOps automation using two Infrastructure as Code approaches.

**Ansible** is used for configuration management and application deployment, while **Terraform** is used to declaratively provision and scale containerized infrastructure.

Together, the implementations demonstrate:

```text
Infrastructure
      ↓
Automation
      ↓
Configuration Management
      ↓
Application Deployment
      ↓
Containerized Infrastructure
      ↓
Scalable Infrastructure
```

---

## 👨‍💻 Author

**Karan Singh**

GitHub: [@KuruHe](https://github.com/KuruHe)

---

## 📚 Repository

**Lab 3 – DevOps**

This repository was created as part of the academic **Lab 3: Monitoring, Logging & DevSecOps** assignment.
