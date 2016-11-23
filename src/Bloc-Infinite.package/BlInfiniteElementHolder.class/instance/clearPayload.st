private - invalidate
clearPayload

	payloads ifNotNil: [ payloads removeAll ].
	self flagDatasourceFullUpdate: false