geometry position convertion
parentPointToLocal: aPoint
	"Transform a given point from parent to my local coordinates"
	<return: #Point>
	| pt |

	pt := aPoint translateBy: self position negated.
	pt := self transform inverseTransformPoint: pt.
	^ pt