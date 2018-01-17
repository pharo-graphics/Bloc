private - accessing
eventClass: aBlEventClass
	self
		assert: [ eventClass isNil ]
		description: [ 'Filter event class can not be changed once set' ].

	eventClass := aBlEventClass