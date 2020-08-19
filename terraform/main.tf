provider "aws" {
  profile = "default"
  # Deploy in Ireland (eu-west-1) region for the moment
  region = "eu-west-2"
}

//data "aws_ami" "amazon-linux-2" {
//  most_recent = true
//
////  filter {
////    name   = "owner-alias"
////    values = ["amazon"]
////  }
//
//  filter {
//    name   = "architecture"
//    values = ["x86_64"]
//  }
//
//  filter {
//    name   = "name"
//    values = ["amzn2-ami-hvm*"]
//  }
//  owners = ["amazon"]
//}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
//  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags          = {
    Name        = "Application Server"
    Environment = "production"
    Terraform   = "true"
    Version     = "0.1.1"
    Component   = "nx-clickhouse"
    Type        = "cluster-node"
  }
}
