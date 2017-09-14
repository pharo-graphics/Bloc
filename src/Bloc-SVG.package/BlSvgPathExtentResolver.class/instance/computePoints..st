computing
computePoints: aCollection
	| currentPoint |
	aCollection do: [ :aPoint | 
			currentPoint := self convertToAbsolutePoint: aPoint.
			minPoint := minPoint min: currentPoint.
			maxPoint := maxPoint max: currentPoint ].
	previousPoint := currentPoint