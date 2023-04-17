# ----- COMPUTE ----- #
variable "host_os" {
  type    = string
  default = "linux"
}

# ----- AUTH ----- # 
variable "identity_file" {
  type    = string
  default = "~/.ssh/cbx-key"
}
variable "key_name" {
  type    = string
  default  = "cbxkey"
}