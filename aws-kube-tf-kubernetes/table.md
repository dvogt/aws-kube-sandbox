## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.kub_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.kub_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.sg_kub_workers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.egress_all_kub_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv4_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv4_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv4_icmp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv6_443](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv6_80](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.egress_ipv6_icmp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ingress_all_kub_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ingress_icmp_bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.ingress_ssh_bastion_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_vpc_id"></a> [aws\_vpc\_id](#input\_aws\_vpc\_id) | n/a | `string` | `""` | no |
| <a name="input_kub_worker_instance_type"></a> [kub\_worker\_instance\_type](#input\_kub\_worker\_instance\_type) | n/a | `string` | `""` | no |
| <a name="input_kube_controller_ami"></a> [kube\_controller\_ami](#input\_kube\_controller\_ami) | n/a | `string` | `""` | no |
| <a name="input_kube_controller_ip"></a> [kube\_controller\_ip](#input\_kube\_controller\_ip) | n/a | `string` | `""` | no |
| <a name="input_kube_worker_ami"></a> [kube\_worker\_ami](#input\_kube\_worker\_ami) | n/a | `string` | `""` | no |
| <a name="input_kube_workers_ips"></a> [kube\_workers\_ips](#input\_kube\_workers\_ips) | n/a | `map(any)` | n/a | yes |
| <a name="input_latest_ubuntu_ami"></a> [latest\_ubuntu\_ami](#input\_latest\_ubuntu\_ami) | n/a | `string` | `""` | no |
| <a name="input_module_name"></a> [module\_name](#input\_module\_name) | n/a | `string` | `"kub-workers"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | `""` | no |
| <a name="input_sg_bastion_id"></a> [sg\_bastion\_id](#input\_sg\_bastion\_id) | n/a | `string` | `""` | no |
| <a name="input_sn_kub_workers"></a> [sn\_kub\_workers](#input\_sn\_kub\_workers) | n/a | `string` | `""` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kub_controller_private_ip"></a> [kub\_controller\_private\_ip](#output\_kub\_controller\_private\_ip) | n/a |
| <a name="output_kub_worker_private_ip"></a> [kub\_worker\_private\_ip](#output\_kub\_worker\_private\_ip) | n/a |
| <a name="output_sg_kub_workers_id"></a> [sg\_kub\_workers\_id](#output\_sg\_kub\_workers\_id) | n/a |
