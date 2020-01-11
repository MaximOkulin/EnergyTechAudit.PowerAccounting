USE [master];
GO

IF  EXISTS (SELECT * FROM sys.server_event_sessions WHERE name = N'EnergyTechAudit.PowerAccounting.Database.DeadlockMonitor') 
BEGIN
  DROP EVENT SESSION [EnergyTechAudit.PowerAccounting.Database.DeadlockMonitor] ON SERVER 
END;

GO

CREATE EVENT SESSION [EnergyTechAudit.PowerAccounting.Database.DeadlockMonitor] ON SERVER 

ADD EVENT sqlserver.xml_deadlock_report 

ADD TARGET package0.event_file
(
	SET filename=N'EnergyTechAudit.PowerAccounting.Database.DeadlockMonitor',
	max_file_size = (250),
	max_rollover_files = (10)
)
WITH 
(
	MAX_MEMORY = 16384 KB,
	EVENT_RETENTION_MODE = ALLOW_SINGLE_EVENT_LOSS,
	MAX_DISPATCH_LATENCY = 30 SECONDS,
	MAX_EVENT_SIZE = 0 KB,
	MEMORY_PARTITION_MODE = NONE,
	TRACK_CAUSALITY = OFF,
	STARTUP_STATE = ON
)
GO

ALTER EVENT SESSION [EnergyTechAudit.PowerAccounting.Database.DeadlockMonitor]
ON SERVER
STATE = START

