geometry position convertion
parentPointToLocal: aPoint
	^ aPoint translateBy: self position negated.