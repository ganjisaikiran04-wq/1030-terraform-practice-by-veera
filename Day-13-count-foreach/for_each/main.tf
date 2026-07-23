resource "aws_instance" "name" {
    ami = "ami-002192a70217ac181"
    instance_type = "t2.micro"
    for_each = toset(var.tags)
    tags = {
        Name = each.key
    }
  
}

