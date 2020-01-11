CREATE PARTITION FUNCTION [ArchivePartitionByPeriodType]
	(
		int
	)
	AS RANGE LEFT
	FOR VALUES (1, 2, 3, 4, 5)
