layout - anchor
updateAnchorFromPendingData: anAnchorInfo
	"If there is a pending scroll position, updates the anchor info from that data and returns true.
	false otherwise"
	<return: #Boolean>

	(self state isPreLayout or: [ self hasPendingScrollPosition not ])
		ifTrue: [ ^ false ].
	
	"validate scroll position"
	(pendingScrollPosition between: 1 and: self state itemCount)
		ifFalse: [ 
			pendingScrollPosition := NoPosition.
			pendingScrollPositionOffset := self class invalidOffset.
			^ false ].

	"if child is visible, try to make it a reference child and ensure it is fully visible.
	if child is not visible, align it depending on its virtual position."
	anAnchorInfo position: pendingScrollPosition.
	
	pendingScrollPositionOffset = self class invalidOffset
		ifTrue: [ 
			self updateAnchorFromPendingDataInvalidOffset: anAnchorInfo.
			^ true ].
	
	"override layout from end values for consistency"
	anAnchorInfo layoutFromEnd: shouldReverseLayout.
	
	"if this changes, we should update prepareForDrop as well"
	anAnchorInfo coordinate: (shouldReverseLayout
		ifTrue: [ self orientation endWithPadding - pendingScrollPositionOffset ]
		ifFalse: [ self orientation startWithPadding + pendingScrollPositionOffset ]).
	
	^ true