resource "aws_security_group" "jenkins_sg" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "vpc-******"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
