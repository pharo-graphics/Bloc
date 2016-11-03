grammar media
mediaQuery
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]