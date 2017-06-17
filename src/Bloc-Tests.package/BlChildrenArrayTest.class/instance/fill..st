instance creation
fill: aNumber
	| childrenArray |
	
	childrenArray := BlChildrenArray new.
	
	1 to: aNumber do: [ :anIndex |
		| anElement |
		anElement := BlElement new.
		anElement userData at: #index put: anIndex.
		childrenArray add: anElement ].
	
	^ childrenArray