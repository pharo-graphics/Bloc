geometry
globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor
	<return: #Collection of: #BPoint>
	| aFromPoint aToPoint theBoundsInSpace aFromRay aToRay aDirectionVector aLength |

	aFromPoint := self globalPositionWithin: aGeometryElement.
	aToPoint := anAnotherAnchor globalPositionWithin: aGeometryElement.

	theBoundsInSpace := self referenceElement bounds inSpace bounds.
	
	aFromRay := theBoundsInSpace outsideNormalCloseTo: aFromPoint.
	aToRay := theBoundsInSpace outsideNormalCloseTo: aToPoint.

	(aFromRay vector isParallel: aToRay vector)
		ifTrue: [
			aFromRay vector rotateBy: 45 degreesToRadians.
			aToRay vector rotateBy: 45 negated degreesToRadians. ].
	
	aDirectionVector := (aToPoint - aFromPoint) asBlocVector * 2.
	aLength := aDirectionVector length max: 150.
	
	^ {
		aFromRay point + (aFromRay vector * aLength).
		aToRay point + (aToRay vector * aLength)
	}