instance creation
rope: aRope from: aStart to: anEnd
	super rope: aRope from: aStart to: anEnd.
	subIterator := aRope rope iterator: aStart to: anEnd