geometry position convertion
globalPointToParent: aPoint
	"Transform a given point from the coordinates of my root most parent to my parent's coordinates"
	<return: #Point>

	^ self hasParent
		ifTrue: [ self parent globalPointToLocal: aPoint ]
		ifFalse: [ aPoint ]