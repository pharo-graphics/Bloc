geometry position convertion
localPointToGlobal: aPoint
	"Transform a given point from my local coordinates to the coordinates of the root most parent"
	<return: #Point>
	| pt |

	pt := self localPointToParent: aPoint.
	^ self hasParent
		ifTrue: [ self parent localPointToGlobal: pt ]
		ifFalse: [ pt ]