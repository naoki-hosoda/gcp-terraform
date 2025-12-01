#########################################
# Variables for BigQuery Scheduled Query
#########################################

variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "query_file" {
  type = string
}

variable "query_params" {
  type    = map(string)
  default = {}
}

variable "display_name" {
  type    = string
  default = ""
}

variable "start_time" {
  type    = string
  default = null
}

variable "schedule" {
  type    = string
  default = "every day 15:00" # UTCで設定のためAsia/Tokyoは+9時間ずれる
}

variable "service_account_name" {
  type    = string
  default = "exec-scheduled-query@test-proj.iam.gserviceaccount.com"
}
