geometry
globalPositionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aMajor aMinor aReferenceBounds aNearestBounds aDirectionVector k x y intersection |
	
	aReferenceBounds := self referenceElement boundsInSpace.
	aNearestBounds := self nearestToElement boundsInSpace.
	
	aDirectionVector := (aNearestBounds center - aReferenceBounds center) asBlocVector.
	
	aMajor := (aReferenceBounds width / 2.0).
	aMinor := (aReferenceBounds height / 2.0).
	
	
	k := (aMajor * aMinor) /
			((aMajor * aMajor * aDirectionVector y * aDirectionVector y) +
				(aMinor * aMinor * aDirectionVector x * aDirectionVector x)) sqrt.
				
	x := k * aDirectionVector x.
	y := k * aDirectionVector y.
	
	intersection := ((x @ y) distanceTo: aDirectionVector) < ((x @ y) negated distanceTo: aDirectionVector)
		ifTrue: [ (x @ y) ]
		ifFalse: [ (x @ y) negated ].
		
	^ aReferenceBounds center + intersection