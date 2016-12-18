layout - state
updateLayoutStateStart
	"Return how much we can scroll without adding new children (independent of layout)"
	<return: #Number>
	| anElement |

	"get the first child in the direction we are going"
	anElement := self childClosestToStart.

	"the direction in which we are traversing children"
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection head ]).
	
	layoutState currentPosition: (self childPositionOf: anElement) + layoutState itemDirection multiplier.
	layoutState offset: (self orientation decoratedStart: anElement).
		
	^ self orientation startWithPadding - (self orientation decoratedStart: anElement)