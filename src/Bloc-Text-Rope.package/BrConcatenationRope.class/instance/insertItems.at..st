rope - inserting
insertItems: aCollection at: anIndex
	| leftSize aNewLeft aNewRight |
	self assertIndexForInsert: anIndex.

	leftSize := left size.
	aNewLeft := left.
	aNewRight := right.
	
	anIndex <= leftSize
		ifTrue: [ aNewLeft := left insertItems: aCollection at: anIndex ].
	
	anIndex > leftSize
		ifTrue: [ aNewRight := right insertItems: aCollection at: anIndex - leftSize ].

	^ self class concatenate: aNewLeft and: aNewRight