variable "region" {}
variable "ami_id" {}
variable "key_name" {}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}