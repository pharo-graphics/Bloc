accessing
nextSegment: aBlock
	"Return a segment of item for those aBlock answers false"
	| fromIndex toIndex initialValue |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	"store position right before iteration"
	fromIndex := self position.
	
	"we want to have homogenous segments, so check what is the initial value"
	initialValue := aBlock value: self peek.
	self next.

	"we skip all items that do not belong to segment"
	[ self hasNext and: [ (aBlock value: self peek) = initialValue ] ] whileTrue: [ self next ].
	
	toIndex := (fromIndex = self position)
		ifTrue: [ self hasNext ifTrue: [ self next ]. fromIndex ]
		ifFalse: [ self position - 1 ].

	^ self rope from: fromIndex to: toIndex