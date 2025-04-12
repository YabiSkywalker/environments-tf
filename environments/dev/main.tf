locals {
/*
  main_vpc_id                     = module.umeet-vpc.vpc-id["main-vpc"]
  security_group                  = module.umeet-vpc.security_group_id
  igw_id                          = module.umeet-vpc.igw_id
  route-table-id                  = module.umeet-vpc.route-table-id
  subnet-id                       = module.umeet-vpc.subnet_id
*/
  google-proj-svc-name                = module.google-apigee.google-project-service-project
  google-proj-svc-id                  = module.google-apigee.google-project-service-id
  google-project-service              = module.google-apigee.google-project-service
  google-apigee-org-id                = module.google-apigee.google-apigee-organization-id
  google-apigee-environment-name      = module.google-apigee.google-apigee-environment-name
  google-apigee-instance-id           = module.google-apigee.google-apigee-instance-id
  google-compute-network-id           = module.google-apigee.google-compute-network-id
  google-compute-global-address-name  = module.google-apigee.google-compute-global-address-name
}

/*
module "umeet-vpc" {
  source = "../../modules/AmazonWebServices/network"

  vpc                 = {
    main-vpc = {
      cidr_block  = "10.0.0.0/24"
      enable_dns_hostnames  = true
      tags        = {
        env = "dev-vpc"
      }
    }
  }

  subnets             = {
    api-subnet = {
      vpc_id                  = local.main_vpc_id
      cidr_block              = "10.0.0.0/25"
      map_public_ip_on_launch = true

      tags        = {
        env = "api-dev-subnet"
      }
    }

    kafka-subnet = {
      vpc_id      = local.main_vpc_id
      cidr_block  = "10.0.0.128/25"
      map_public_ip_on_launch = false

      tags        = {
        env = "kafka-dev-subnet"
      }
    }
  }
  security_group      = {
    umeet-sg = {
      name          = "api-sg"
      description   = "Allow TLS inbound traffic and all outbound traffic"
      vpc_id        = local.main_vpc_id

      tags        = {
        resource = "security_group_all_tls"
      }
    }

    kafka-sg  = {
      name          = "kafka-sg"
      description   = "Allow traffic only from API"
      vpc_id        = local.main_vpc_id

      tags        = {
        resource = "security_group_all_tls"
      }
    }
  }

  security_group_rule = {
    allow-ing-22 = {
      type = "ingress"
      security_group_id = local.security_group["umeet-sg"]
      cidr_block = ["0.0.0.0/0"]
      from_port = 22
      to_port = 22
      protocol = "tcp"
    }
    allow-ing-80 = {
      type = "ingress"
      security_group_id = local.security_group["umeet-sg"]
      cidr_block = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      from_port = 80
      to_port = 80
      protocol = "tcp"
    }

    allow-ing-443 = {
      type = "ingress"
      security_group_id = local.security_group["umeet-sg"]
      cidr_block = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      from_port = 443
      to_port = 443
      protocol = "tcp"
    }

    allow-egress = {
      type = "egress"
      security_group_id = local.security_group["umeet-sg"]
      cidr_block = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      from_port = 0
      to_port = 0
      protocol = "-1"
    }

    allow-kafka-in =   {
      type = "ingress"
      security_group_id = local.security_group["kafka-sg"]
      cidr_block = ["0.0.0.0/0"]
      from_port = 9092
      to_port = 9092
      protocol = "tcp"
    }

    allow-kafka-out =   {
      type = "egress"
      security_group_id = local.security_group["kafka-sg"]
      cidr_block = ["10.0.0.0/25"]
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
  }

  igw            = {
    api-igw = {
      vpc_id = local.main_vpc_id
      tags = {
        env  = "api-igw"
     }
    }
  }

  route-table      = {
    api-route-table = {
      vpc_id  = local.main_vpc_id
      tags = {
        name  = "api-route-table"
     }
    }
  }

  route               = {
    api-route = {
      route_table_id          = local.route-table-id["api-route-table"]
      gateway_id              = local.igw_id["api-igw"]
      destination_cidr_block  = "0.0.0.0/0"
  }
}

  route-association = {
    api-association = {
      subnet_id      = local.subnet-id["api-subnet"]
      route_table_id = local.route-table-id["api-route-table"]
    }
  }

}

module "umeet_api_role" {
  source = "../../modules/AmazonWebServices/iam"

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
  source                        = "../../modules/AmazonWebServices/s3"

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
 source = "../../modules/AmazonWebServices/ec2"

 instances = {
   web-1 = {
     ami_id                        = "ami-04b4f1a9cf54c11d0"
     instance_type                 = "t2.micro"
     subnet_id                     = module.umeet-vpc.subnet_id["api-subnet"]
     key_name                      = "yab"
     vpc_security_group_ids        = [module.umeet-vpc.security_group_id["umeet-sg"]]
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
     subnet_id                     = module.umeet-vpc.subnet_id["kafka-subnet"]
     key_name                      = "yab"
     vpc_security_group_ids        = [module.umeet-vpc.security_group_id["kafka-sg"]]
     associate_public_ip_address   = false
     iam_instance_profile           = module.umeet_api_role.iam_instance_profile_name

     tags = {
       env  = "dev"
       role = "kafka"
     }
   }
 }
}

module "route53_record" {
  source = "../../modules/AmazonWebServices/route53"

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
*/

/* ------------------ GOOGLE APIGEE ------------------ */
data "google_client_config" "current" {}

module "google-apigee" {
  source = "../../modules/GoogleCloudPlatform/APIGEE"

  google-project-service     = {
    umeet-project-service = {
        project = "umeet-gate"
        service = "apigee.googleapis.com"
    }

    umeet-network-service = {
        project = "umeet-gate"
        service = "servicenetworking.googleapis.com"
    }
  }

  google-compute-network = {
    umeet-api-gateway-vpc = {
      project   = local.google-proj-svc-name["umeet-project-service"]
      name      = "umeet-api-gateway-network"
    }
  }

  google-compute-global-address = {
    umeet-compute-global-address = {
        name          = "apigee-range"
        project       = "umeet-gate"
        purpose       = "VPC_PEERING"
        address_type  = "INTERNAL"
        prefix_length = 16
        network       = local.google-compute-network-id["umeet-api-gateway-vpc"]
    }
  }

    google-service-networking-connection = {
    umeet-service-networking-conection = {
      network                 = local.google-compute-network-id["umeet-api-gateway-vpc"]
      service                 = local.google-project-service["umeet-network-service"]
      reserved_peering_ranges = [local.google-compute-global-address-name["umeet-compute-global-address"]]
    }
  }

  google-apigee-organization = {
    umeet-apigee-org = {
      project_id         = "umeet-gate"
      //data.google_client_config.current.project
      //local.google-proj-svc-id["umeet-project-service"]
      analytics_region   = "us-central1"
      authorized_network = local.google-compute-network-id["umeet-api-gateway-vpc"]
    }
  }

  google-apigee-environment = {
    umeet-apigee-env = {
      org_id = local.google-apigee-org-id["umeet-apigee-org"]
      name   = "umeet-dev"
    }
  }

  google-apigee-instance     = {
    umeet-apigee-instance = {
        name             = "umeet-dev-apigee-instance"
        org_id           = local.google-apigee-org-id["umeet-apigee-org"]
        location         = "us-central1"
        #runtime_ip_range = "10.138.0.0/20"

    }
  }
  google-apigee-environment-attachment = {
    umeet-apigee-environment-attachment = {
        environment = local.google-apigee-environment-name["umeet-apigee-env"]
        instance_id = local.google-apigee-instance-id["umeet-apigee-instance"]
    }
  }
}
