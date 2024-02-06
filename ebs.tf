resource "aws_ebs_volume" "example" {
  for_each =  var.create_ebs_volume ? var.ec2_config : {}
  availability_zone     = aws_instance.ec2_instance[each.key].availability_zone
  encrypted             = true
  type                  = var.ebs_type
  size                  = var.ebs_size
  kms_key_id            = var.kms_key_id
  tags                  = merge({ "Name" = each.key }, var.tags)
}

resource "aws_volume_attachment" "ebs_att" {
  for_each =  var.create_ebs_volume ? var.ec2_config : {}
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example[each.key].id
  instance_id = aws_instance.ec2_instance[each.key].id
}

