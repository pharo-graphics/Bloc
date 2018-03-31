private - layout anchor
prepareAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState
	"I update anchor position and coordinate if this information is not valid"
	| aFirstLayoutItemDirection |

	(anAnchorInfo isValid not
		or: [ self hasPendingScrollPosition ])
			ifTrue: [ 
				anAnchorInfo reset.
				anAnchorInfo layoutFromEnd: shouldReverseLayout ~= stackFromEnd.
				"calculate anchor position and coordinate"
				self updateAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState.
				anAnchorInfo isValid: true	].

	aFirstLayoutItemDirection := (anAnchorInfo layoutFromEnd
		ifTrue: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection head ] ]
		ifFalse: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ] ]).
	
	
	self onAnchorReady: anAnchorInfo firstLayoutItemDirection: aFirstLayoutItemDirection