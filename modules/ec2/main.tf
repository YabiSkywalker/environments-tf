resource "aws_instance" "this" {
  for_each                      = var.instances
  ami                           = each.value.ami_id
  instance_type                 = each.value.instance_type
  subnet_id                     = each.value.subnet_id
  key_name                      = each.value.key_name
  vpc_security_group_ids        = each.value.vpc_security_group_ids
  associate_public_ip_address   = each.value.associate_public_ip_address

  tags = merge(
    {
      Name = each.key
    },
    each.value.tags
 )
}

