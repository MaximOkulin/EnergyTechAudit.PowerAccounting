SELECT

	[Request].[session_id] [Session ID],
	[Request].[start_time] [Request Start],
	[Request].[status] [Current State],
	[Request].[command] [Request Command],
	[SqlQuery].[text] [Query],
	[Plan].[query_plan] [Execution Plan],
	[Session].[login_name] [Login]

FROM sys.dm_exec_requests [Request]
	OUTER APPLY sys.dm_exec_sql_text([Request].sql_handle) [SqlQuery]
	OUTER APPLY sys.dm_exec_query_plan([Request].plan_handle) [Plan]
	CROSS APPLY sys.dm_exec_sessions [Session]

WHERE 
[Request].[session_id] > 50 AND 
[Request].[session_id] <> @@SPID  
-- AND [Request].[status] = 'suspended'

