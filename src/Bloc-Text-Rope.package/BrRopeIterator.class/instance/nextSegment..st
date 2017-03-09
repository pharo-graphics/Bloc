accessing
nextSegment: aBlock
	"Return a segment of item for those aBlock answers false"
	| fromIndex toIndex wasFound |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	fromIndex := self position.
	wasFound := false.
	
	"we skip all items that do not belong to segment"
	[ self hasNext and: [ (wasFound := (aBlock value: self next)) not ] ] whileTrue.
	
	toIndex := fromIndex = (self position - 1)
		ifTrue: [ fromIndex ]
		ifFalse: [ wasFound
			ifTrue: [ self position - 2 ]
			ifFalse: [ self position - 1 ] ].

	^ self rope from: fromIndex to: toIndex