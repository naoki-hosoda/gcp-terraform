#########################################
# BigQuery Scheduled Query Module
#########################################

locals {
  # start_timeが指定されていない場合は、現在時刻の1時間後を設定
  computed_start_time = var.start_time != null ? var.start_time : timeadd(timestamp(), "1h")
}

resource "google_bigquery_data_transfer_config" "scheduled_query" {

  project        = var.project_id
  location       = var.region
  display_name   = var.display_name != "" ? var.display_name : "scheduled_query_tf"
  data_source_id = "scheduled_query"
  schedule       = var.schedule

  service_account_name = var.service_account_name

  params = {
    query = templatefile(var.query_file, var.query_params)
  }

  schedule_options {
    start_time = local.computed_start_time
  }
}
