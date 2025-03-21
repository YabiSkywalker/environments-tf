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

resource "aws_instance" "this" {
 for_each      = var.instances
 ami           = each.value.ami_id
 instance_type = each.value.instance_type
 subnet_id     = aws_subnet.main_subnet.id

 tags = merge(
   {
     Name = each.key
   },
   each.value.tags
 )
}