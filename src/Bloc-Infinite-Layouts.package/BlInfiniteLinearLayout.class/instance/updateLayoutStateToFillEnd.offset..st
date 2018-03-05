layout - state
updateLayoutStateToFillEnd: aPosition offset: anOffset
	| anAvailableSpace aLimitedSpace |
	
	anAvailableSpace := self orientation endWithPadding - anOffset.
	aLimitedSpace := self orientation maximumSpace - self orientation paddingEnd.
	(aLimitedSpace isInfinite not and: [ layoutState isInfinite ])
		ifFalse: [ anAvailableSpace := aLimitedSpace ].
	
	layoutState availableSpace: anAvailableSpace in: self.

	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ]).

	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection end.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset