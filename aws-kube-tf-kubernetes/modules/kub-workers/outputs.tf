output "kub_worker_private_ip" {
  value = aws_instance.kub_worker[*].private_ip
}

output "kub_controller_private_ip" {
  value = aws_instance.kub_controller.private_ip
}

output "sg_kub_workers_id" {
  value = aws_security_group.sg_kub_workers.id
}
