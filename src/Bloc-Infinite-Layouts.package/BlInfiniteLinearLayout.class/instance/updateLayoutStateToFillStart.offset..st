layout - state
updateLayoutStateToFillStart: aPosition offset: anOffset

	layoutState availableSpace: anOffset - self orientation startWithPadding in: self.
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection head ]).

	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection start.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset