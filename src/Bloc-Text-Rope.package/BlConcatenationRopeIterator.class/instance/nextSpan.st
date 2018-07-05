iterator - enumeration
nextSpan
	| theAttributes aStart anEnd |
	self hasNext
		ifFalse: [ self error: 'reached end of rope' ].

	aStart := position max: 1.
	theAttributes := self attributes.

	[ self hasNext and: [ self attributes = theAttributes ] ] whileTrue: [ 
		| nextRun |
		nextRun := currentIterator nextSpan.
		self moveForward: nextRun size ].
	
	anEnd := ((position - 1) max: 1) min: end.
	
	^ rope from: aStart to: anEnd