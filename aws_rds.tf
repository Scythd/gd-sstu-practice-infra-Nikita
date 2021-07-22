resource "aws_db_subnet_group" "appDBGroup" {
  name       = "db_for_app_group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.crutch.id]

  tags = {
    Name = "DB subnet group for App"
  }
}

resource "aws_db_instance" "appDB" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "petclinic"
  username             = "petclinic"
  password             = "petclinic"
  db_subnet_group_name = aws_db_subnet_group.appDBGroup.name
  port                 = 3306
  availability_zone    = "us-east-1a"

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    Name = "App DB"
  }
}