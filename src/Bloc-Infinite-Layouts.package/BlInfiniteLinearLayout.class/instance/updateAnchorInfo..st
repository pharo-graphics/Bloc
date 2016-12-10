layout - anchor
updateAnchorInfo: anAnchorInfo
	
	(self updateAnchorFromPendingData: anAnchorInfo)
		ifTrue: [ ^ self ].
		
	(self updateAnchorFromChildren: anAnchorInfo)
		ifTrue: [ ^ self ].
		
	anAnchorInfo assignCoordinateFromPaddingIn: self.
	anAnchorInfo position: (stackFromEnd
		ifTrue: [ self state itemCount ]
		ifFalse: [ 1 ])