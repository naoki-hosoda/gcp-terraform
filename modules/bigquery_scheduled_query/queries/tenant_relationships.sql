CREATE OR REPLACE TABLE `${project_id}.${dataset_id}.tenant_relationships` AS
SELECT *
FROM EXTERNAL_QUERY(
    "${cloudsql_id}",
    "SELECT * FROM public.tenant_relationships;"
  );