selection - handling
handleSelected: anElement in: aSelectionInLocal
	| anIntersection anEvent |

	anIntersection := self
		intersect: anElement
		in: aSelectionInLocal
		ifNone: [ self error: 'Selected child must intersect with selection' ].

	anEvent := BlElementSelectionAcquiredEvent new.
	anEvent bounds: anIntersection.
	anEvent target: anElement.
	anElement dispatchEvent: anEvent.

	^ anEvent isConsumed