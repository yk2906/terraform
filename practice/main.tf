resource "aws_security_group" "yk0956tfdev" {

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["60.130.227.208/32"] # SSHを許可（セキュリティのため、必要に応じてIPを制限）
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["60.130.227.208/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 全てのアウトバウンド通信を許可
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2インスタンス
resource "aws_instance" "yk0956tfdev" {
  ami           = "ami-0b2cd2a95639e0e5b" # Amazon Linux 2 AMI (リージョンに応じて変更)
  instance_type = "t2.micro"              # 無料利用枠に適したインスタンスタイプ

  vpc_security_group_ids = [aws_security_group.yk0956tfdev.id]

  tags = {
    Name = "terraform-managed"
  }
}