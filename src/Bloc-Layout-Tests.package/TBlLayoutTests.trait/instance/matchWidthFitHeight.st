instance creation
matchWidthFitHeight
	^ BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical fitContent ]