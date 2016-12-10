initialization
initialize
	super initialize.
	
	colors := (Color registeredColorNames asOrderedCollection collect: [ :aName | Color named: aName asSymbol ]) last: 5