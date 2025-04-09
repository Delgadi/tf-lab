provider "aws" {
    region = "us-west-2"

}

# --- Network Setup ---
module "network" {
  source              = "../../modules/network"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  environment         = "dev"
}

# --- Security Groups ---
module "security" {
  source  = "../../modules/security"
  vpc_id  = module.network.vpc_id
  environment = "dev"
}

# --- Compute (EC2 Instance) ---
module "compute" {
  source         = "../../modules/compute"
  subnet_id      = module.network.private_subnet_id
  security_group = module.security.sg_id
  environment    = "dev"
}

# --- Cloudflare Integration ---
module "cloudflare" {
  source         = "../../modules/cloudflare"
  zone_name      = var.cloudflare_zone_name
  record_name    = var.cloudflare_record_name
  instance_ip    = module.compute.instance_public_ip
  environment    = "dev"
}

resource "aws_network_acl" "public_nacl" {
    vpc_id = module.network.vpc_id
    subnet_ids = [module.network.public_subnet_id]

}

# Deny rule 
# Deny rule: Block specific malicious IP
resource "aws_network_acl_rule" "deny_malicious_ip" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"                # all protocols
  rule_action    = "deny"
  cidr_block     = "203.0.113.99/32"
}

# Allow all other ingress (for simplicity)
resource "aws_network_acl_rule" "allow_all_ingress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 200
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Allow all outbound traffic
resource "aws_network_acl_rule" "allow_all_egress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}
