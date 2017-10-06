instance creation
newGridElement

	^ BlElement new
		layout: BlGridLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ]