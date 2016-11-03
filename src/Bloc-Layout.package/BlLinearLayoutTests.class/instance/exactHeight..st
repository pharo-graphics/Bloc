instance creation
exactHeight: aNumber
	^ BlElement new
		constraintsDo: [ :c |
			c vertical exact: aNumber ];
		yourself