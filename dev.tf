provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
 
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

resource "aws_instance" "murali" {
  ami = "0e86e20dae9224db8"
  instance_type = "t2.medium"
  key_name = "susmitha"
  vpc_security_group_ids = [ "sg-0a42e27da7ff32bf6" ]
  tags = {
    Name = "susmitha"
  }
  
provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-venv -y",
        "sudo apt install python3-virtualenv -y",
        "python3 -m venv /home/ubuntu/mohan",
        ". /home/ubuntu/mohan/bin/activate",
        "git clone https://github.com/Susmithavardireddy/teerdha19.git",
        "cd teerdha19",
        "sudo apt install libmysqlclient-dev -y",
        "sudo apt install pkg-config -y",
        "pip install -r requirements.txt",
        "pip install django",
        "pip install mysqlclient",
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
      private_key = file("susmitha.pem")  
      host     = self.public_ip  
    }
 }
}
