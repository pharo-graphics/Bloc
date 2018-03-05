layout - state
updateLayoutStateToFillStart: aPosition offset: anOffset
	| anAvailableSpace |
	
	anAvailableSpace := anOffset - self orientation startWithPadding.
	
	layoutState availableSpace: anAvailableSpace in: self.
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection head ]).

	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection start.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset