selection - handling
handleSelected: anElement in: anIntersection
	| anEvent |

	"we should make sure that we don't destroy existing BlBounds by performing destructive operation"
	self
		assert: [ anIntersection ~~ self selectionArea  ]
		description: [ 'Intersection must be a different bounds object than selection area' ].
	
	anEvent := BlElementSelectionAcquiredEvent new.
	anEvent bounds: anIntersection encompass.
	anEvent target: anElement.
	anElement dispatchEvent: anEvent.

	^ anEvent isConsumed