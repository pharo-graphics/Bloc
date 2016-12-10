initialization
assignFromElementAndKeepVisible: anElement in: aLinearLayout

	aLinearLayout orientation totalSpaceChange >= 0
		ifTrue: [ ^ self assignFromElement: anElement in: aLinearLayout ].
		
	position := aLinearLayout childPositionOf: anElement.

	layoutFromEnd
		ifTrue: [ self assignFromElementAndKeepVisibleFromStart: anElement in: aLinearLayout ]
		ifFalse: [ self assignFromElementAndKeepVisibleFromEnd: anElement in: aLinearLayout ].