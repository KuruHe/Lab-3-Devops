# Part 2 - Terraform: Provision Scalable Infrastructure

## What this demonstrates
Terraform is used as Infrastructure as Code to:
- initialize a project,
- download/configure the Docker provider,
- create an Nginx image resource,
- provision multiple Nginx containers using `count`,
- expose each instance on a different host port,
- show the resulting infrastructure through Terraform outputs.

This is intentionally local so it can be demonstrated without cloud credentials.

## Prerequisites
- Terraform >= 1.5
- Docker Desktop or Docker Engine running

Check:

```bash
terraform version
docker version
```

## Initialize

```bash
cd 2_terraform
terraform init
```

## Review configuration

```bash
terraform fmt
terraform validate
```

## Plan

```bash
terraform plan
```

## Apply

```bash
terraform apply
```

Type `yes` when prompted.

## Verify

```bash
terraform output
docker ps
```

Open:
- http://localhost:8081
- http://localhost:8082

## Demonstrate scalability

Create 3 instances:

```bash
terraform apply -var="instance_count=3"
```

The third instance will be available on:

```text
http://localhost:8083
```

Terraform manages the desired count, so changing `instance_count` demonstrates Infrastructure as Code scalability.

## Destroy when finished

```bash
terraform destroy
```

Type `yes` when prompted.

## Evidence to capture
1. `terraform init` showing successful provider initialization.
2. `terraform plan` showing resources to add.
3. `terraform apply` showing resources created.
4. `terraform output` and `docker ps`.
5. Browser output from at least one provisioned container.
6. Optional: a second `terraform apply -var="instance_count=3"` showing scaling.
