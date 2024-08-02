provider "aws" {
  region = "us-east-2"
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  # Define ingress and egress rules for RDS
   # ssh for terraform remote exec
  ingress {
    description = "Allow remote SSH from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  # enable http
  ingress {
    description = "Allow HTTP request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
  }

}

resource "aws_instance" "kumar" {
  ami = "ami-0862be96e41dcbf74"
  instance_type = "t2.medium"
  key_name = "praveen"
  vpc_security_group_ids = [ "sg-0e7783eb3e866cde2" ]
  tags = {
    Name = "kumar"
  }
  
provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-venv -y",
        "sudo apt install python3-virtualenv -y",
        "python3 -m venv /home/ubuntu/kumar",
        "cd /home/ubuntu/kumar/bin/activate",
        "git clone https://github.com/Praveenchinna14/teerdha19.git",
        "cd teerdha19",
        "sudo apt install libmysqlclient-dev -y",
        "sudo apt install pkg-config -y",
        "pip install -r requirements.txt",
        "pip install django",
        "pip install django-crsipy-forms",
        "pip install django-rest-framework",
        "pip install requests",
        "pip install pyscopg2-binary",
        "pip install wheel",
        "pip install pillow",
        "pip install easy-pil",
        "python /home/ubuntu/teerdha19/manage.py makemgrations",
        "python /home/ubuntu/teerdha19/manage.py migrate",
        "python /home/ubuntu/teerdha19/manage.py runserver 0.0.0.0:8000"     
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"  
      private_key = file("praveen.pem")  
      host     = self.public_ip  
    }
 }
}

