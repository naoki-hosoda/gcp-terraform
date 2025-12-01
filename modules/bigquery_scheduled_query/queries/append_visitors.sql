INSERT INTO `${project_id}.${dataset_id}.visitors`
SELECT DATE(visited_at) AS visited_at_date,
  created_at,
  updated_at,
  uid,
  id,
  hwid,
  dm,
  visited_at
FROM EXTERNAL_QUERY(
    "${cloudsql_id}",
    """SELECT *
    FROM public.visitors
    WHERE DATE(created_at) = DATE(CURRENT_DATE - INTERVAL '1 day');"""
  );