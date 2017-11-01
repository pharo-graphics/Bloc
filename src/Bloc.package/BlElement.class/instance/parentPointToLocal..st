geometry position convertion
parentPointToLocal: aPoint
	"Transform a given point from parent to my local coordinates"
	<return: #Point>
	| aLocalPoint |

	aLocalPoint := aPoint translateBy: self position negated.
	aLocalPoint := self transformation inverseTransformPoint: aLocalPoint.
	^ aLocalPoint