private - layout anchor
updateAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState

	(self updateAnchorFromPendingData: anAnchorInfo state: aBlInfiniteState)
		ifTrue: [ ^ self ].

	(self updateAnchorFromChildren: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState)
		ifTrue: [ ^ self ].

	anAnchorInfo assignCoordinateFromPaddingIn: self.
	anAnchorInfo position: (stackFromEnd
		ifTrue: [ self state itemCount ]
		ifFalse: [ 1 ])