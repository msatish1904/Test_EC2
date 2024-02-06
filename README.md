# Introduction
TF module for creating Ec2 instance along with Security group,Root volume,Ebs volume and attaching instance Role.

## Description

Provision [EC2 instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Instances.html)

This module provides recommended settings.

- Creating EC2 instance
- attach  the root & ebs volumes and security group to the EC2.

## Installation

```shell

git clone https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-ec2.git
cd tf-mod-ec2

Update with required and appropriate details in the respective field 

```
## To run this example you need to execute below

To initialize the Terraform directory, run the following command:
```hcl
terraform init
```
To generate an execution plan, run the following command:
```hcl
terraform plan
```
To apply the execution plan, run the following command:
```hcl
terraform apply
```
Note that this example may create resources which cost money. Run ``` terraform destroy``` when you don't need these resources.

## Requirements

| Name      | Version    |
| --------- |------------|
| terraform | `>= 1.4.6` |

## Inputs

| Name                            | Description                                                                                                     | Type     | Default | Required |
|---------------------------------|-----------------------------------------------------------------------------------------------------------------|----------|------|:--------:|
| vpc_id                          | The vpc in which the ec2 has to be created                                                                      | `string` | ``   |   yes    |
| subnet_id                       | The subnet in which the ec2 has to be created                                                                   | `string` | ``   |   yes    |
| create_ebs_volume               | whether the ebs volume has to be create or not                                                                  | `bool`   | false |   yes    |
| ami                             | The AMi based on which the ec2 has to be created                                                                | `string` | ``   |   yes    |
| instance_type                   | The type of instance to be created                                                                              | `string` | ``   |   yes    |
| associate_public_ip_address     | Whether the public ip has to be set for the instance or not                                                     | `bool`   | true |   yes    |
| user_data                       | The pre defined user data to be passed to the instance                                                          | `string` | ``   |   yes    |
| hibernation                     | The hibernation of the instance to be set or not                                                                | `bool`   | false |   yes    |
| instance_termination_protection | If the instance has to be protected against accidental termination                                              | `bool`   | true |   yes    |
| instance_stop_protection        | If the instance has to be protected against accidental stoppage                                                 | `bool`   | true |   yes    |
| cloudwatch_monitoring           | If the cloudwatch monitoring has to be enabled                                                                  | `bool`   | ``   |   yes    |
| volume_deletion_on_termination  | If the root volume has to be deleted after termination                                                          | `bool`   | true |   yes    |
| volume_size                     | the size of the root volume                                                                                     | `string` | `10` |   yes    |
| volume_type                     | the type of the root volume                                                                                     | `string` | `gp2` |   yes    |
| ebs_size                        | the size of the ebs volume                                                                                      | `string` | `10` |   yes    |
| ebs_type                        | the type of the ebs volume                                                                                      | `string` | `gp2` |   yes    |
| cpu_credits                     | the type of cpu credits to be used                                                                              | `string` | `standard` |   yes    |
| aws_managed_policy              | The ARN of the policy we want to apply                                                                          | `list`   | ``   |   yes    |
| force_detach_policies           | Whether to force detaching any policies the role has before destroying it. Allowed values are "false" or "true" | `string` | false |   yes    |
| iam_policy_definitions          | The policy document. This is a JSON formatted string                                                            | `string` | ``   |   yes    |
| iam_policy_description          | Description of the IAM policy.                                                                                  | `string` | ``   |   yes    |
| iam_policy_name                 | The name of the policy. If omitted, Terraform will assign a random, unique name.                                | `string` | ``   |   yes    |
| iam_policy_path                 | Path in which to create the policy                                                                              | `string` | `/`  |   yes    |
| iam_role_definitions            | Policy that grants an entity permission to assume the role.  		                                             | `string` | `` 	 |   yes    |
| iam_role_description            | Description of the IAM role.                                                                                    | `string` | `` 	 |   yes    |
| iam_role_name                   | The name of the role. If omitted, Terraform will assign a random, unique name.                                  | `string` | ``   |   yes    |
| iam_role_path                   | Path to the role                                                                                                | `string` | `/`  |   yes    |
| ec2_profile_name                | The profile to be attached to instance                                                                          | `string` | ``   |   yes    |
| max_session_duration            | Maximum session duration (in seconds) that we want to set for the specified role.                               | `string` | `3600` |   yes    |
| permissions_boundary            | ARN of the policy that is used to set the permissions boundary for the role.                                    | `string` | ``   |   yes    |
| sg_description                  | Description of the Security Group                                                                               | `string` | ``   |   yes    |
| key_name                        | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resourc         | `string` | ``   |   yes    |
| region                          | Default region for deployed resources                                                                           | `string` | `us-east-1` |   yes    |
| tags                            | Common baseline tags. List of tags can be found in the module example below                                     | `map`    | ``   |   yes    |

## Example of module usage (tfvars.tf)
To create ec2 instance and attach the security group
```hcl
module "ec2" {
  source                  = "git::https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-ec2.git?ref=master"
  region                  = "us-east-1"
  iam_policy_definitions  = "${file("${path.module}/iam_ec2_policy.json")}"
  iam_role_definitions    = "${file("${path.module}/iam_ec2_role.json")}"
  iam_policy_path         = "/"
  iam_policy_description  = "This Policy is for EC2 to access backend resources"
  iam_policy_name         = "cloudopds-poc-ec2-policy"
  aws_managed_policy      = ["AmazonSSMManagedInstanceCore", "AmazonElastiCacheFullAccess"]
  iam_role_name           = "cloudops-poc-ec2-role"
  iam_role_description    = "This role is for EC2 to access backend resources"
  iam_role_path           = "/"
  max_session_duration    = "3600"
  permissions_boundary    = ""
  ec2_profile_name        = "cloudops-ec2-profile"
  force_detach_policies   = "false"
  key_name                = "cloudops-poc"
  subnet_id               = "subnet-0084689113a9a1dfc"
  
  ebs_size                = "10"
  ebs_type                = "gp2"
  create_ebs_volume       = "false" 
  kms_key_id              = "arn:aws:kms:us-east-1:xxxxxxxxxx:key/xxxxxxxx-xxxx-xxx"

  ec2_config = {
    "cloudops-poc-ec2-1" = {
      ami                             = "ami-0715c1897453cabd1"
      instance_type                   = "t2.nano"
      associate_public_ip_address     = "true"
      user_data                       = "${file("${path.module}/init.sh")}"
      hibernation                     = "false"
      instance_termination_protection = "true"
      instance_stop_protection        = "true"
      volume_deletion_on_termination  = "true"
      volume_size                     = "64"
      volume_type                     = "gp2"
      cpu_credits                     = "standard"
      sg_id                           = ["${module.sg_1.sg_id}","${module.sg_2.sg_id}"]
    }
  
    "cloudops-poc-ec2-2" = {
      ami                             = "ami-0715c1897453cabd1"
      instance_type                   = "t2.micro"
      associate_public_ip_address     = "true"
      user_data                       = "${file("${path.module}/init.sh")}"
      hibernation                     = "false"
      instance_termination_protection = "true"
      instance_stop_protection        = "true"
      volume_deletion_on_termination  = "true"
      volume_size                     = "15"
      volume_type                     = "gp2"
      cpu_credits                     = "standard"
      sg_id                           = ["${module.sg_2.sg_id}"]
    }
    
  }


  tags = {
    "Project"     = "" ## The name of the project that the resource is used for.
    "Application" = "" ## The name of the application or feature of that the resource belongs to.
    "Owner"       = "" ## The email address of the person or team that owns the resource (@altimetrik.com)
    "Environment" = "" ## The environment in which the resource is used. Allowed values are "Test", "QA", "Staging", "Development", "Non-Prod", "Sandbox", "UAT", "Prod"
  }

}


module "sg_1" {
  source      = "git::https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-sg.git?ref=master"
  region      = "us-east-1"
  name        = "test1"
  vpc_id      = "vpc-****"
  description = "This is for ingress/egress traffic Security Group"

  inbound_ports_cidr            = "80,443"
  inbound_protocol_cidr         = "tcp"
  inbound_cidr_block_cidr       = ["0.0.0.0/0", "0.0.0.0/0"]
  description_rule_ingress_cidr = ["incoming traffic from internet on port 80", "incoming traffic from internet on port 443"]

  outbound_ports_cidr                  = "0,0"
  outbound_protocol_cidr               = "-1"
  outbound_cidr_block_cidr             = ["0.0.0.0/0", "10.0.0.0/16"]
  description_rule_egress_cidr         = ["All egress traffic", "All egress traffic from vpc"]

  inbound_ports_source_sg              = "9011,9020"
  inbound_protocol_source_sg           = "tcp"
  inbound_security_group_id_source_sg  = ["sg-0******", "sg-0******"]
  description_rule_ingress_source_sg   = ["Incoming traffic from port 9011", "Incoming traffic from port 9020"] 

  outbound_ports_source_sg             = "80,8080"
  outbound_protocol_source_sg          = "tcp"
  outbound_security_group_id_source_sg = ["sg-0*****", "sg-0******"]
  description_rule_egress_source_sg    = ["egress traffic to ALB SG", "egress traffic to ALB"]

  tags = {
    "Project"     = "" ## The name of the project that the resource is used for.
    "Application" = "" ## The name of the application or feature of that the resource belongs to.
    "Owner"       = "" ## The email address of the person or team that owns the resource (@altimetrik.com)
    "Environment" = "" ## The environment in which the resource is used. Allowed values are "Test", "QA", "Staging", "Development", "Non-Prod", "Sandbox", "UAT", "Prod"
  }

}

module "sg_2" {
  source = "git::https://git.altimetrik.com/bitbucket/scm/cloudauto/tf-mod-sg.git?ref=master"
  region      = "us-east-1"
  name        = "test2"
  vpc_id      = "vpc-****"
  description = "This is for ingress/egress traffic Security Group"

  inbound_ports_cidr            = "80,443"
  inbound_protocol_cidr         = "tcp"
  inbound_cidr_block_cidr       = ["10.2.0.0/16", "10.0.0.0/16"]
  description_rule_ingress_cidr = ["incoming traffic from internet on port 80", "incoming traffic from internet on port 443"]

  outbound_ports_cidr                  = "0,0"
  outbound_protocol_cidr               = "-1"
  outbound_cidr_block_cidr             = ["20.0.0.0/16", "10.1.0.0/16"]
  description_rule_egress_cidr         = ["All egress traffic", "All egress traffic from vpc"]

  inbound_ports_source_sg              = "9012,9040"
  inbound_protocol_source_sg           = "tcp"
  inbound_security_group_id_source_sg  = ["sg-0****", "sg-0****"]
  description_rule_ingress_source_sg   = ["Incoming traffic from port 9011", "Incoming traffic from port 9020"] 

  outbound_ports_source_sg             = "22,8081"
  outbound_protocol_source_sg          = "tcp"
  outbound_security_group_id_source_sg = ["sg-0****", "sg-0****"]
  description_rule_egress_source_sg    = ["egress traffic to ec2 SG", "egress traffic to ALB"]

  tags = {
    "Project"     = "" ## The name of the project that the resource is used for.
    "Application" = "" ## The name of the application or feature of that the resource belongs to.
    "Owner"       = "" ## The email address of the person or team that owns the resource (@altimetrik.com)
    "Environment" = "" ## The environment in which the resource is used. Allowed values are "Test", "QA", "Staging", "Development", "Non-Prod", "Sandbox", "UAT", "Prod"
  }


}

terraform {
  backend "s3" {
    bucket         = ""
    key            = ""
    region         = ""
    encrypt        = "true"
    dynamodb_table = ""
  }
}
```

### Example iam_ec2_role.json
```hcl
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "sts:AssumeRole"
        ],
        "Principal": {
          "Service": [
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  }
```

### Example iam_ec2_policy.json
```hcl
{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "secretsmanager:GetRandomPassword",
          "secretsmanager:ListSecrets"
        ],
        "Resource": "*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "eks:*",
        "Resource": "*"
      }
    ]
  }
```
### init.sh
```hcl
#!/bin/bash
echo Hostname of this ec2 instance is $hostname
```

### Example outputs.tf to export the outputs
```hcl
output "private_key_pem" {
  description = "Public Ssh key deployed to AKS nodes"
  value       = module.ec2.private_key_pem
  sensitive   = true
}

output "Ec2-Id" {
  description = "Instance id"
  value = module.ec2.Ec2-Id
}

output "instance_arn" {
  description = "value"
  value = module.ec2.instance_arn
}

output "public_ip"{
  value = module.ec2.public_ip
  description = "public ip of the instance"
}

output "private_ip" {
  value = module.ec2.private_ip
  description = "private ip of the instance"
}

output "root_volume_details" {
  value = module.ec2.root_volume_details
  description = "size of the root block device"
  
}

output "ebs_volume_id" {
  value = module.ec2.ebs_volume_id
  description = "size of the ebs block device"
  
}
output "ebs_volume_size" {
  value = module.ec2.ebs_volume_size
  description = "size of the ebs block device"
}

output "iam_role_name" {
  value = module.ec2.iam_role_name
  description = "iam role attached to the instance"
}

output "sg_id_1" {
  value = module.sg_1.sg_id
  description = "The ID of the security group"
}
output "vpc_id_1" {
  value = module.sg_1.vpc_id
  description = "The VPC ID of the sg-1"
}
output "name_1" {
  value = module.sg_1.name
  description = "The name of the security group-1"
}
output "arn_1" {
  value = module.sg_1.arn
  description = "The ARN of the security group-1"
}
output "description_1" {
  value = module.sg_1.description
  description = "The description of the security group-1"
}

output "sg_id_2" {
  value = module.sg_2.sg_id
  description = "The ID of the security group-2"
}
output "vpc_id_2" {
  value = module.sg_2.vpc_id
  description = "The VPC ID of the security group-2"
}
output "name_2" {
  value = module.sg_2.name
  description = "The name of the security group-2"
}
output "arn_2" {
  value = module.sg_2.arn
  description = "The ARN of the security group-2"
}
output "description_2" {
  value = module.sg_2.description
  description = "The description of the security group-2"
}
```

## Outputs

| Name               | Description                                    |
|--------------------|------------------------------------------------|
| private_key_pem        | keyfile to login to the ec2 instance|
| sg_id_1/ sg_id_2          | the securitygroup attached to ec2 instance-1/instance-2    |
| Ec2-id   | The unique ID of the instance |
| instance_arn      | The ARN of the instance                        |
| public_ip       | public ip address of the instance                             |
| private_ip        | priavte ip address of instnace                              |
| ebs_volume_id   | the id of ebs volume attached   |
| ebs_volume_size      | The size of the ebs volume attached                       |
| roor_volume_details        | The root volume details of the ec2       |
| iam_role_name      | The name of the role attached to ec2                |
| vpc_id             | The VPC ID in which esecurity group is created  |
| name               | The name of the security group                 |
| arn                | The ARN of the security group                  |
| description        | The description of the security group          |



| Version | Description                                      |
|---------|--------------------------------------------------|
| 1.0.0   | Initial version of Ec2 related resources |
