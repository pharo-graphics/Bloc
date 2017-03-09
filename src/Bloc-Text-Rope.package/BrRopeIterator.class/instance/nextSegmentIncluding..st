accessing
nextSegmentIncluding: aBlock
	"Return a segment of item for those aBlock answers false including "
	| fromIndex toIndex |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].
	
	fromIndex := self position.
	
	"we skip all items that do not belong to segment"
	[ self hasNext and: [ (aBlock value: self next) not ] ] whileTrue.

	toIndex := self position - 1.
	fromIndex = toIndex
		ifTrue: [ toIndex := fromIndex ].

	^ self rope from: fromIndex to: toIndex