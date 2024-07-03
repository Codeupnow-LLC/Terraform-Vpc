output "instance_public_ip" {
  description = "The public IP address of the Nginx instance"
  value       = aws_instance.nginx_instance.public_ip
}