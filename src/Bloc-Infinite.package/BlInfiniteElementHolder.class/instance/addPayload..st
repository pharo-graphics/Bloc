accessing - payload
addPayload: anObject
	anObject
		ifNil: [ ^ self addEmptyPayload ].

	self flags hasDataSourceFullUpdate
		ifFalse: [ payloads add: anObject ]