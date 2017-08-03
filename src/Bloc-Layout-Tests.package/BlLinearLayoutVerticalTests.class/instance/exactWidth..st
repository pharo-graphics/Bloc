instance creation
exactWidth: aNumber
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal exact: aNumber ];
		yourself