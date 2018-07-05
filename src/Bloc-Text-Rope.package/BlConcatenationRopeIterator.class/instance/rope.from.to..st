instance creation
rope: aRope from: aStart to: anEnd
	super rope: aRope from: aStart to: anEnd.

	position := aStart.
	currentIterator := self forwardIteratorAt: aStart