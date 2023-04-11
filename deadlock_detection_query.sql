SELECT
    [DeadlockGraph] = CAST(xet.target_data AS XML),
    [DeadlockTime] = xet.event_date
FROM
    sys.dm_xe_session_targets AS xet
INNER JOIN
    sys.dm_xe_sessions AS xe
    ON (xe.address = xet.event_session_address)
WHERE
    xe.name = 'system_health'
    AND xet.target_name = 'ring_buffer'
    AND CAST(xet.target_data AS XML).value('(event/@name)[1]', 'nvarchar(1000)') = 'xml_deadlock_report';