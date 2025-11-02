resource "random_password" "db_pass" {
  length  = 16
  special = true
}

resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-${var.environment}-db-subnet"
  subnet_ids = var.subnet_ids

  tags = {
    Name        = "${var.project_name}-${var.environment}-db-subnet"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_security_group" "rds_sg" {
  name   = "${var.project_name}-${var.environment}-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_db_instance" "appdb" {
  identifier             = "${var.project_name}-${var.environment}-rds"
  engine                 = "postgres"
  engine_version         = "15.3"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  username               = var.db_username
  password               = random_password.db_pass.result
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  multi_az               = true
  storage_encrypted      = true
  publicly_accessible    = false

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
