instance creation - hand
hand
	<gtExample>

	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c |
			c vertical fitContent.
			c horizontal exact: 200.
			c frame horizontal alignCenter.
			c frame vertical alignCenter ];
		yourself