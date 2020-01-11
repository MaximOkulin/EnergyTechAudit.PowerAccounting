
SELECT 
   user_seeks * avg_total_user_cost * (avg_user_impact * 0.01) [Index_Useful]
  ,[IndexGroupStatistic].[last_user_seek]
  ,[IndexDetail].[statement] AS [Statement]
  ,[IndexDetail].[equality_columns]
  ,[IndexDetail].[inequality_columns]
  ,[IndexDetail].[included_columns]
  ,[IndexGroupStatistic].[unique_compiles]
  ,[IndexGroupStatistic].[user_seeks]
  ,[IndexGroupStatistic].[avg_total_user_cost]
  ,[IndexGroupStatistic].[avg_user_impact]

FROM sys.dm_db_missing_index_group_stats [IndexGroupStatistic]

  INNER JOIN sys.dm_db_missing_index_groups [IndexGroup]
    ON [IndexGroupStatistic].[group_handle] = [IndexGroup].[index_group_handle]

  INNER JOIN sys.dm_db_missing_index_details AS [IndexDetail]
    ON [IndexGroup].[index_handle] = [IndexDetail].[index_handle]

ORDER BY [Index_Useful] DESC;