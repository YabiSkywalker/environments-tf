module "umeet_vpc" {
  source = "../../modules/network"

  security_group_tag        = "allow_tls"
  api_subnet_tag            = "api_subnet"
  kafka_subnet_tag          = "kafka_subnet"
  vpc_tag                   = "main_vpc"
}

module "umeet_instances" {
 source = "../../modules/ec2"

 instances = {
   web-1 = {
     ami_id                        = "ami-04b4f1a9cf54c11d0"
     instance_type                 = "t2.micro"
     subnet_id                     = module.umeet_vpc.api_subnet_id
     key_name                      = "yab"
     vpc_security_group_ids        = [module.umeet_vpc.security_group_id]
     associate_public_ip_address   = true

     tags = {
       env  = "dev"
       role = "api"
     }
   }

   web-2 = {
     ami_id                        = "ami-04b4f1a9cf54c11d0"
     instance_type                 = "t2.micro"
     subnet_id                     = module.umeet_vpc.kafka_subnet_id
     key_name                      = "yab"
     vpc_security_group_ids        = [module.umeet_vpc.security_group_id]
     associate_public_ip_address   = true

     tags = {
       env  = "dev"
       role = "kafka"
     }
   }
 }
}

module "umeet_bucket" {
  source                        = "../../modules/s3"

  bucket                        = "umeet-dev-bucket"
  force_destroy                 = true
  block_public_acl              = false
  block_public_policy           = false
  ignore_public_acl             = false
  enable_versioning             = true
  bucket_iam_policy_name        = "umeet_bucket_iam_policy_name"

  tags                  = {
    name = "meet-dev-bucket-tag"
  }
}