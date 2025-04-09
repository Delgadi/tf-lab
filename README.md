
# Network Security Terraform Lab

## Overview

This lab simulates a perimeter security infrastructure using Terraform across AWS and Cloudflare. It's designed to evaluate your proficiency in IaC practices, network security, and incident response.

## Objectives

- Provision a secure VPC with public and private subnets
- Deploy an EC2 instance in a private subnet
- Implement firewall rules using AWS Security Groups (simulating Palo Alto behavior)
- Integrate Cloudflare with DNS and WAF settings
- Handle a simulated incident by blocking a malicious IP

## Structure

```
terraform-lab/
├── modules/
│   ├── network/         # VPC, Subnets, Routes
│   ├── compute/         # EC2 Instance
│   ├── security/        # Security Groups (Firewall simulation)
│   └── cloudflare/      # Cloudflare WAF/CDN example
├── environments/
│   └── dev/             # Example environment configs
├── provider.tf
├── backend.tf
└── README.md
```

## Setup Instructions

1. **Install prerequisites**:
    - Terraform >= 1.0
    - AWS CLI configured
    - Cloudflare API token

2. **Initialize Terraform**:
    ```bash
    terraform init
    ```

3. **Validate configuration**:
    ```bash
    terraform validate
    ```

4. **Plan and Apply**:
    ```bash
    terraform plan -var-file=environments/dev/terraform.tfvars
    terraform apply -var-file=environments/dev/terraform.tfvars
    ```

## What to Submit

- Your updated Terraform code
- Documentation of:
  - Diagram and Architecture decisions
  - Security rules and their rationale
  - How you handled the simulated incident
  - Any issues encountered and how you debugged them
- Optional: GitHub Actions / CI integration for Terraform

## Simulated Incident

An external IP (`203.0.113.99`) is attempting to scan ports on your public subnet. Identify and block this access using Terraform.

## Notes

- Assume IAM roles and secrets are handled outside this lab
- You are encouraged to improve structure or security posture if time allows
