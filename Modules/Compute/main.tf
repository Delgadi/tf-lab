
resource "aws_instance" "example" {
  ami           = "ami-0c5204531f799e0c6"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  tags = {
    Name = "ExampleInstance"
  }
}
