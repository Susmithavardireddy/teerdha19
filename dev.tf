provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "dev" {
  ami = "0e86e20dae9224db8"
  instance_type = "t2.medium"
  key_name = "susmitha"
  vpc_security_group_ids = [ "sg-0a42e27da7ff32bf6" ]
  tags = {
    Name = "dev"
  }
  
provisioner "remote-exec" {
    inline = [
        "sudo apt-get update",
        "sudo apt-get upgrade -y",
        "sudo apt install python3-pip -y",
        "sudo apt install python3-venv -y",
        "sudo apt install python3-virtualenv -y",
        "pip install virtualenv",
        "python3 -m venv /home/ubuntu/kumar",
        ". /home/ubuntu/kumar/bin/activate",
        "git clone https://github.com/Susmithavardireddy/teerdha19.git",
        "cd teerdha19",
        "sudo apt install libmysqlclient-dev -y",
        "sudo apt install pkg-config -y",
        "pip install -r requirements.txt",
        "pip install django",
        "pip install django-rest-framework",
        "pip install mysqlclient",
        "pip install requests",
        "pip install pyscopg2-binary",
        "pip install wheel",
        "pip install pillow",
        "python3 /home/ubuntu/teerdha19/manage.py makemigrations",
        "python3 /home/ubuntu/teerdha19/manage.py migrate",
        "python3 /home/ubuntu/teerdha19/manage.py runserver 0.0.0.0:8000"     
    ]
    connection {
      type     = "ssh"
      user     = "ubuntu"  
      private_key = file("susmitha.pem")  
      host     = self.public_ip  
    }
 }
}
