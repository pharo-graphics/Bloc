parent
withParent: aBlock ifAbsent: anAbsentBlock
	^ self parent ifNil: anAbsentBlock ifNotNil: aBlock