resource "aws_instance" "public_instance" {
  ami = "ami-026c3177c9bd54288"
  instance_type = "t2.micro"
  count = 1
  
  subnet_id = var.subnet_id
  tags = {
    name = "UbuntuInstance"
  }
}
