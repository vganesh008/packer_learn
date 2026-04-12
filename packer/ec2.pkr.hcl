packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
source "amazon-ebs" "learn" {
  ami_name      = "packer-example"
  instance_type = "t2.micro"
  region        = "var.region"
  access_key    = "XXXXXXXXXXXX"
  secret_key    = "XXXXXXXXXXXXX"
  source_ami_filter {
    filters = {
      name                = "XXXXXXXXXXX"
      root-device-type    = "XXXXXXXXXXX"
      virtualization-type = "XXXXXXXXXXX"
    }
    owners      = ["XXXXXXXXXXX"]
    most_recent = true
  }
  ssh_username = "ec2-user"
}

build {
  name    = "XXXXXXXXXXX"
  sources = ["source.amazon-ebs.learn"]
  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo yum install httpd -y",
    ]
  }
  provisioner "ansible" {
    playbook_file = "ganesh.yml"
  }
  provisioner "file" {
    source      = "test.sh"
    destination = "/var/tmp"
  }
  provisioner "shell" {
    script = "./test.sh"
  }
}