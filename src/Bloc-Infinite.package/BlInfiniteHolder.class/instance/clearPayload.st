accessing - payload
clearPayload

	payloads ifNotNil: [ payloads removeAll ].
	self flags clearDataSourceFullUpdate