terraform {

  backend "gcs" {
    bucket = "test-proj-terraform-state"
  }

  required_version = "~> 1.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "7.5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

#########################################
# BigQuery Scheduled Query
#########################################

locals {
  scheduled_queries = {
    tenant_relationships = {
      display_name = "replace_tenant_relationships_tf"
      query_file   = "tenant_relationships.sql"
      schedule     = "every day 15:00"
    }
    append_visitors = {
      display_name = "append_visitors_tf"
      query_file   = "append_visitors.sql"
      schedule     = "every day 15:10"
    }
  }
}

module "bigquery_scheduled_queries" {
  source   = "./modules/bigquery_scheduled_query"
  for_each = local.scheduled_queries

  project_id   = var.project_id
  region       = var.region
  display_name = each.value.display_name
  schedule     = each.value.schedule
  query_file   = "${path.module}/modules/bigquery_scheduled_query/queries/${each.value.query_file}"

  query_params = {
    project_id  = var.project_id
    dataset_id  = "app_db"
    cloudsql_id = "0000000000000.asia-northeast1.test-sql-instance"
  }
}
