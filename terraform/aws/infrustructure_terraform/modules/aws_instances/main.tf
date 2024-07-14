resource "aws_instance" "public_instance" {
  ami = "ami-026c3177c9bd54288"
  instance_type = "t2.micro"
  security_groups = [var.sec_gr]
  subnet_id = var.subnet_id
  tags = {
    name = "UbuntuInstance"
  }
}

resource "aws_eip" "aws_pub_iep" {
  instance = aws_instance.public_instance.id
}