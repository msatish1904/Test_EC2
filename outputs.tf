output "private_key_pem" {
  description = "Public Ssh key deployed to AKS nodes"
  value = tls_private_key.ssh.private_key_pem
  sensitive = true
}

output "Ec2-Id" {
  description = "Instance id"
  value = {for k,v in aws_instance.ec2_instance : k=>v.id}
}

output "instance_arn" {
  description = "value"
    value = {for k,v in aws_instance.ec2_instance : k=>v.arn}
}

output "public_ip"{
  value = {for k,v in aws_instance.ec2_instance : k=>v.public_ip}
  description = "public ip of the instance"
}

output "private_ip" {
  value = {for k,v in aws_instance.ec2_instance : k=>v.private_ip}
  description = "private ip of the instance"
}

output "ebs_volume_id" {
  value = {for k,v in aws_ebs_volume.example : k=>v.id}
  description = "size of the ebs block device"
  
}

output "ebs_volume_size" {
  value = {for k,v in aws_ebs_volume.example : k=>v.size}
  description = "size of the ebs block device"

}

output "root_volume_details" {
  value = {for k,v in aws_instance.ec2_instance : k=>v.root_block_device}
  description = "size of the root block device"
}

output "iam_role_name" {
  value = aws_iam_role.ec2_role.name
  description = "iam role attached to the instance" 
}

