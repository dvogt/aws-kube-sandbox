

resource "aws_instance" "kub_controller" {

  # count = var.instance_count
  private_ip = var.kube_controller_ip
  instance_type = var.kub_worker_instance_type
  ami = var.kube_controller_ami
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # The name of our SSH keypair we created above.
  key_name = var.ssh_key

  # Our Security group to allow HTTP and SSH access
  # vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  vpc_security_group_ids = [
    aws_security_group.sg_kub_workers.id,
    aws_security_group.sg_kub_controller.id
  ]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = var.sn_kub_workers.id


  tags = {
    Name = "kub_controller"
    Type = "private"
  }
  

  timeouts {
    create = "15m"
    delete = "20m"
  }

  metadata_options {
    http_endpoint               = "enabled"   # keep IMDS on, but…
    http_tokens                 = "required"  # …force IMDSv2
    http_put_response_hop_limit = 1           # only the instance itself can reach it
    instance_metadata_tags      = "disabled"  # don’t expose tags via IMDS
  }

  # user_data = file("${path.module}/ud_kube-init-and-join.sh")
  #user_data = file("${path.module}/ud_kube-init-and-join.sh")
  user_data                   = local.ctrl_cloud_init
  user_data_replace_on_change = true
  
  depends_on = [
    aws_vpc_endpoint.ssm,
    aws_vpc_endpoint.secrets_manager,
    aws_vpc_endpoint.s3,
  ]
}


