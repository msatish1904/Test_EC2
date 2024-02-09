variable "region" {
  type = string
  description = "region in which ec2 is located"
  default = "us-east-1"
}

variable "ec2_config" {
  description                       = "EC2 Configurations"
  type                              = map(object({
    ami                             = string
    instance_type                   = string
    associate_public_ip_address     = bool
    user_data                       = string
    hibernation                     = bool
    instance_termination_protection = bool
    instance_stop_protection        = bool
    volume_deletion_on_termination  = bool
    volume_size                     = string
    volume_type                     = string
    cpu_credits                     = string
    sg_id                           = list(string)
  }))
}


variable "key_name" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "subnet in which the ec2 lies in"
  type = string
  default = ""
}

variable "ebs_size"{
  type = string
  description = "size of the ebs value"
  default = "10"
}

variable "ebs_type" {
  type = string
  description = "type of the ebs value"
  default = ""
}

variable "create_ebs_volume" {
  type = bool
  default  = "false" 
}

variable "ec2_profile_name" {
  type = string
  description = "The profile to be attached to instance"
  default = ""
}

variable "iam_role_name" {
  description = "The name of the role. If omitted, Terraform will assign a random, unique name."
  type = string
  default = ""
}

variable "iam_role_path" {
  description = "Path to the role"
  type        = string
  default     = "/"
}

variable "aws_managed_policy" {
  description = "The ARN of the policy we want to apply"
  type        = list(string)
  default     = [""]
}

variable "iam_policy_name" {
  description = "The name of the policy. If omitted, Terraform will assign a random, unique name."
  type = string
  default = ""
}

variable "iam_policy_path" {
  description = "Path in which to create the policy"
  type        = string
  default     = "/"
}

variable "iam_policy_description" {
  description = "Description of the IAM policy."
  type        = string
  default     =  ""
}

variable "iam_policy_definitions" {
  description = "The policy document. This is a JSON formatted string"
  type        = string
  default     = ""
}

variable "iam_role_definitions" {
  description = "Policy that grants an entity permission to assume the role."
  type = string
  default = ""
}

variable "iam_role_description" {
  description = "Description of the IAM role."
  type        = string
  default     = ""
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = ""
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that we want to set for the specified role."
  type    = string
  default = "3600"
}

variable "force_detach_policies" {
  description = "Whether to force detaching any policies the role has before destroying it"
  type        = bool
  validation {
    condition     = contains([false, true], var.force_detach_policies)
    error_message = "Argument 'force_detach_policies' must be one of 'false', 'true'"
} 

  default     = false

} 

variable "kms_key_id" {
  type        = string
  description = "kms key id of the instance to which the volume is to be attached"
}

variable "kms_key_id1234" {
  type        = string
  description = "kms key id of the instance to which the volume is to be attached"
  key         = string
  text        = value
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}


