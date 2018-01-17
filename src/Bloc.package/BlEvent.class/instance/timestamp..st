private - accessing
timestamp: aDateAndTime

	self
		assert: [ aDateAndTime isNumber not ]
		description: [ 'Number can not be used as a timestamp, use DateAndTime instead' ].

	timestamp := aDateAndTime