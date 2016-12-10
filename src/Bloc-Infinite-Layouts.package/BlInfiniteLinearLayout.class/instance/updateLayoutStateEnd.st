layout - state
updateLayoutStateEnd
	"Return how much we can scroll without adding new children (independent of layout)"
	<return: #Number>
	| anElement |
	
	layoutState extraSpace: layoutState extraSpace + self orientation paddingEnd.
	"get the first child in the direction we are going"
	anElement := self childClosestToEnd.

	"the direction in which we are traversing children"
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ]).
	
	layoutState currentPosition: (self childPositionOf: anElement) + layoutState itemDirection multiplier.
	layoutState offset: (self orientation decoratedEnd: anElement).
	
	^ (self orientation decoratedEnd: anElement) - self orientation endWithPadding