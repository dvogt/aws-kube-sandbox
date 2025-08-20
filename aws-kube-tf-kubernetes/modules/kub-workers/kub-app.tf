

resource "aws_instance" "kub_controller" {

  # count = var.instance_count
  private_ip = var.kube_controller_ip

  instance_type = var.kub_worker_instance_type

  ami = var.kube_controller_ami

  # The name of our SSH keypair we created above.
  key_name = var.ssh_key


  # Our Security group to allow HTTP and SSH access
  # vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  vpc_security_group_ids = [aws_security_group.sg_kub_workers.id]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = var.sn_kub_workers

  tags = {
    Name = "kub_controller"
    Type = "private"
  }

  timeouts {
    create = "15m"
    delete = "20m"
  }

}

resource "aws_instance" "kub_worker" {
  # The connection block tells our provisioner how to
  # communicate with the resource (instance)

  # this will build as many workers as there are ip assigned
  count      = length(var.kube_workers_ips)
  private_ip = lookup(var.kube_workers_ips, count.index)

  connection {
    # The default username for our AMI
    user = "ubuntu"
    host = ""
    # The connection will use the local SSH agent for authentication.
  }

  instance_type = var.kub_worker_instance_type

  ami = var.kube_worker_ami

  # The name of our SSH keypair we created above.
  key_name = var.ssh_key

  # Our Security group to allow HTTP and SSH access
  # vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  vpc_security_group_ids = [aws_security_group.sg_kub_workers.id]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = var.sn_kub_workers

  tags = {
    Name = "kub_worker ${count.index}"
    Type = "private"
  }

  timeouts {
    create = "15m"
    delete = "20m"
  }
}
