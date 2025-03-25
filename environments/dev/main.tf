module "umeet_vpc" {
  source = "../../modules/network"

  vpc                 = {
    main-vpc = {
      cidr_block  = "10.0.0.0/24"
      tags        = {
        env = "dev-vpc"
      }
    }
  }

  subnets             = {
    api-subnet = {
      vpc_id      = module.umeet_vpc.vpc-id
      cidr_block  = "10.0.0.0/25"
      tags        = {
        env = "api-dev-subnet"
      }
    }

    kafka-subnet = {
      vpc_id      = module.umeet_vpc.vpc-id
      cidr_block  = "10.0.0.128/25"
      tags        = {
        env = "kafka-dev-subnet"
      }
    }
  }
  security_group      = {
    umeet-sg = {
      name          = "api-sg"
      description   = "Allow TLS inbound traffic and all outbound traffic"
      vpc_id        = module.umeet_vpc.vpc-id

      tags        = {
        resource = "security_group_all_tls"
      }
    }
  }

  security_group_rule = {
    allow-ipv4 = {
      type = "ingress"
      security_group_id = module.umeet_vpc.security_group_id
      cidr_bloc = ["0.0.0.0/0"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }

    allow-ipv6 = {
      type = "ingress"
      security_group_id = module.umeet_vpc.security_group_id
      cidr_block = ["0.0.0.0/0"]
      from_port = 443
      to_port = 443
      protocol = "tcp"
    }

    allow-ipv4 = {
      type = "egress"
      security_group_id = module.umeet_vpc.security_group_id
      cidr_block = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
  }


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
     subnet_id                     = module.umeet_vpc.subnet_id["api-subnet"]
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
     subnet_id                     = module.umeet_vpc.subnet_id["kafka-subnet"]
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

module "route53_record" {
  source = "../../modules/route53"

  dns_record = {
    linkd-dev = {
      zone_id = "Z07795005D9AWXUA9YB"
      name    = "linkd-dev.yabi.dev"
      type    = "A"
      ttl     = 1
      records = [module.umeet_instances.public-ip["web-1"]]
    }
  }
}
