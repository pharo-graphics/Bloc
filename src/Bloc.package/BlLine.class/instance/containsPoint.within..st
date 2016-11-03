geometry testing
containsPoint: aPoint within: aBounds
	| newPoints |
	newPoints := self pointsWithin: aBounds.
	^ aPoint onLineFrom: newPoints origin to: newPoints corner within: 4