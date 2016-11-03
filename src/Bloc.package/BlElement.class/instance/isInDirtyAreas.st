drawing
isInDirtyAreas
	self dirty ifTrue: [ ^ true ].
	^ self space isNotNil
		and: [ self space dirtyAreas anySatisfy: [ :each | self boundsInSpace intersects: each ] ]