private - invalidate
clearPayload

	payloads ifNotNil: [ payloads removeAll ].
	self flags clearDataSourceFullUpdate