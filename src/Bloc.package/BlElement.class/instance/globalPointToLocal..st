geometry position convertion
globalPointToLocal: aPoint
	"Transform a given point from the coordinates of my root most parent to my local coordinates"
	<return: #Point>
	| pt |

	pt := self hasParent
		ifTrue: [ self parent globalPointToLocal: aPoint ]
		ifFalse: [ aPoint ].

	^ self parentPointToLocal: pt