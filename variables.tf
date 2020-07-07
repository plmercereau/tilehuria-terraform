variable "gcp_region" {
  type    = string
  default = "us-central1"
}

variable "gcp_zone" {
  type    = string
  default = "us-central1-c"
}

# variable "db_table_name" {
#   type    = string
#   default = "terraform-learn"
# }

# variable "db_read_capacity" {
#   type    = number
#   default = 1
# }

# variable "db_write_capacity" {
#   type    = number
#   default = 1
# }

variable "project_id" {
  type = string
}
