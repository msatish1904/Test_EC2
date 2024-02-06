resource "aws_instance" "ec2_instance" {
  for_each                    = var.ec2_config
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  key_name                    = aws_key_pair.ssh.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = each.value.associate_public_ip_address
  vpc_security_group_ids      = each.value.sg_id   
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name  
  user_data                   = each.value.user_data
  hibernation                 = each.value.hibernation
  disable_api_termination     = each.value.instance_termination_protection
  disable_api_stop            = each.value.instance_stop_protection
  monitoring                  = true  #each.value.cloudwatch_monitoring
  ebs_optimized               = true

  root_block_device {
    volume_size               = each.value.volume_size
    volume_type               = each.value.volume_type
    encrypted                 = true
    delete_on_termination     = each.value.volume_deletion_on_termination
  }
  
  credit_specification {
    cpu_credits               = each.value.cpu_credits
  }

  metadata_options {      
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags                        = merge({ "Name" = each.key }, var.tags)
  volume_tags                 = merge({ "Name" = each.key }, var.tags)
}


### skipped timeouts,credit_specification,enclave_options,dynamic maintainence options,launch template,metadata options,ephemeral block device,capacity reservation specification,cpu options,
