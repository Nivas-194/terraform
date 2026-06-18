resource "aws_instance" "ec2" {
  count         = 2
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [var.ec2_sg]
}