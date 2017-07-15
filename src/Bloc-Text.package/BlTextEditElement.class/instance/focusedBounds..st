geometry bounds
focusedBounds: aBlBounds
	"My focused bounds should be focused bounds of a cursor if it exists or my own otherwise"
	<return: #BlBounds>

	^ (self cursorExists and: [ self hasFocus ])
		ifFalse: [ super focusedBounds: aBlBounds ]
		ifTrue: [ self cursor localBoundsToParent: (self cursor focusedBounds: aBlBounds) ]