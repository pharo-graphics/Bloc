private - layout anchor
updateAnchorFromPendingDataInvalidOffset: anAnchorInfo
	| anElement |
	
	anElement := self childAtPosition: pendingScrollPosition.
	anElement
		"Item is not visible"
		ifNotNil: [ self updateAnchor: anAnchorInfo fromChild: anElement ]
		"Item is visible"
		ifNil: [ self hasChildren
				ifTrue: [ | aPosition |
					aPosition := self childPositionOf: (self childAt: 1).
					anAnchorInfo layoutFromEnd: pendingScrollPosition < aPosition = shouldReverseLayout ].
			anAnchorInfo assignCoordinateFromPaddingIn: self ]