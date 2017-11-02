initialization
initialize
	super initialize.
	
	"colors := (Color registeredColorNames asOrderedCollection collect: [ :aName | Color named: aName asSymbol ])".
	colors := ((0 to: 1 by: 0.01) collect: [ :anIndex | self colorAt: anIndex ]) asOrderedCollection