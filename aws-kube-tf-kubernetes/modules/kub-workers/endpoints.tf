


# ##############################################################
# ##################### VPC endpoint for SSM  #################
# ##############################################################

resource "aws_vpc_endpoint" "ssm" {
  # This is allow SSM to work without IPv4
  vpc_id              = var.aws_vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.sn_kub_workers.id]
  security_group_ids  = [aws_security_group.sg_kub_workers.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

# ##############################################################
# ############### VPC endpoint for Secrets Manager  ############
# ##############################################################

resource "aws_vpc_endpoint" "secrets_manager" {
  # This is allow SSM to work without IPv4
  vpc_id              = var.aws_vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.sn_kub_workers.id]
  security_group_ids  = [aws_security_group.sg_kub_workers.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

# ##############################################################
# ############## VPC endpoints for S3.            ##############
# ##############################################################
# S3 Gateway endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.aws_vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   =  [var.route_table.id]# associate with the route tables used by your subnets
  
  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

############################################
#             Endpoint for STS
############################################
resource "aws_vpc_endpoint" "sts" {
  vpc_id              = var.aws_vpc_id
  service_name        = "com.amazonaws.${var.aws_region}.sts"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [var.sn_kub_workers.id]  
  security_group_ids  = [aws_security_group.sg_kub_workers.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}
