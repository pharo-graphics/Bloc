initialization
initialize
	super initialize.
	
	constraintsBlock := [ :c |
		c horizontal exact: 100.
		c vertical exact: 50 ].
	
	colors := Color registeredColorNames collect: [ :aColorName | Color named: aColorName ]