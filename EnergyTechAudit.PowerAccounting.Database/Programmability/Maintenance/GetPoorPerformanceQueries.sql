SELECT TOP 10 dest.text as sql,
  deqp.query_plan,
  creation_time,
  last_execution_time,
  execution_count,
  (total_worker_time / execution_count) as avg_cpu,
  total_worker_time as total_cpu,
  last_worker_time as last_cpu,
  min_worker_time as min_cpu,
  max_worker_time as max_cpu,
  (total_physical_reads + total_logical_reads) as total_reads,
  (max_physical_reads + max_logical_reads) as max_reads,
  (total_physical_reads + total_logical_reads) / execution_count as avg_reads,
  max_elapsed_time as max_duration,
  total_elapsed_time as total_duration,
((total_elapsed_time / execution_count)) / 1000000 as avg_duration_sec

FROM sys.dm_exec_query_stats deqs

CROSS APPLY sys.dm_exec_sql_text(sql_handle) dest

CROSS APPLY sys.dm_exec_query_plan (plan_handle) deqp

ORDER BY deqs.total_worker_time DESC