module "umeet_vpc" {
  source = "../../modules/network"

  security_group_tag        = "allow_tls_dev"
  api_subnet_tag            = "api_subnet_dev"
  kafka_subnet_tag          = "kafka_subnet_dev"
  vpc_tag                   = "main_vpc_dev"
}

module "umeet_api_role" {
  source = "../../modules/iam"

  iam_role_name = "umeet_role_dev"
  iam_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  iam_policy_name = "umeet_role_policy_dev"

  iam_policy_document =   jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${module.umeet_bucket.bucket}/*",
          "arn:aws:s3:::${module.umeet_bucket.bucket}"
        ]
      }
    ]
  })

  iam_instance_profile_name = "umeet_instance_profile_dev"
}

module "umeet_bucket" {
  source                        = "../../modules/s3"

  bucket                        = "umeet-dev-bucket"
  force_destroy                 = true
  block_public_acl              = true
  block_public_policy           = true
  ignore_public_acl             = true
  enable_versioning             = false


  tags                  = {
    name = "meet-dev-bucket-tag"
  }
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
     iam_instance_profile           = module.umeet_api_role.iam_instance_profile_name

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
     iam_instance_profile           = module.umeet_api_role.iam_instance_profile_name

     tags = {
       env  = "dev"
       role = "kafka"
     }
   }
 }
}
