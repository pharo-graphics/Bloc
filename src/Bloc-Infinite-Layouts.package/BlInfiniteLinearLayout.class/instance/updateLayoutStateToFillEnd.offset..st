layout - state
updateLayoutStateToFillEnd: aPosition offset: anOffset
	
	layoutState availableSpace: self orientation endWithPadding - anOffset.
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ]).
	
	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection end.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset