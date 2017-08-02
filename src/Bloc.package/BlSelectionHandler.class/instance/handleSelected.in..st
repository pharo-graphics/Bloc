selection - handling
handleSelected: anElement in: aSelectionInLocal
	| anIntersection anEvent |

	anIntersection := self
		intersect: anElement
		in: aSelectionInLocal
		ifNone: [ self error: 'Selected child must intersect with selection' ].
	
	"we should make sure that we don't destroy existing BlBounds by performing destructive operation"
	self
		assert: [ anIntersection ~~ self selectionArea  ]
		description: [ 'Intersection must be a different bounds object than selection area' ].
	self
		assert: [ anIntersection ~~ aSelectionInLocal ]
		description: [ 'Intersection must be a different bounds object than selection in local' ].
	
	
	anEvent := BlElementSelectionAcquiredEvent new.
	anEvent bounds: anIntersection encompass.
	anEvent target: anElement.
	anElement dispatchEvent: anEvent.

	^ anEvent isConsumed