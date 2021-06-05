resource "aws_security_group" "allow_sql" {
  name        = "allow_sql"
  description = "Allow sql inbound traffic"
  vpc_id      = "vpc-cd879aa5"

  ingress {
    description = "sql from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_db_instance" "myrds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "akash"
  password             = "myredhat"
  availability_zone = "ap-south-1a"
  iam_database_authentication_enabled = true
  vpc_security_group_ids = [ "${aws_security_group.allow_sql.id}"]
  publicly_accessible  = true
  skip_final_snapshot = true
  
  tags = {
    "Name" = "MyDB Instance"
  }
  depends_on = [
    aws_security_group.allow_sql
  ]
}