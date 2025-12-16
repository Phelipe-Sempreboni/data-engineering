
# Define as zonas de disponibilidade

variable "av_zone_a" {
  type = map

  default = {
    us-east-2      = "us-east-2a"
  }
}

variable "av_zone_b" {
  type = map

  default = {
    us-east-2      = "us-east-2b"
  }
}
