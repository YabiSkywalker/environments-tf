

module "umeet_instances" {
 source = "../../ec2"

 instances = {
   web-1 = {
     instance_type = "t2.micro"
     ami_id        = "ami-04b4f1a9cf54c11d0"
     tags = {
       env  = "dev"
       role = "api"
     }
   }

   web-2 = {
     instance_type = "t2.micro"
     ami_id        = "ami-04b4f1a9cf54c11d0"
     tags = {
       env  = "dev"
       role = "kafka"
     }
   }
 }
}