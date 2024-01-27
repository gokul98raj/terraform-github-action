resource "aws_instance" "example" {
  ami           = "ami-0d13e3e640877b0b9"  # Set your desired AMI
  instance_type = "t2.micro"               # Set your desired instance type

  tags = {
    Name = "example-instance"
  }
}