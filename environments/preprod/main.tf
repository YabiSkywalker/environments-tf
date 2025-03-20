resource "aws_vpc" "main_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "main_vpc_tag"
  }
}

resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "main_subnet_tag"
  }
}

resource "aws_instance" "test_ec2" {
  ami           = "ami-0f9de6e2d2f067fca"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main_subnet.id

  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }

  tags = {
    Name = "test_ec2_tag"
  }
}