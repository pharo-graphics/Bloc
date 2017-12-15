geometry
globalPositionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aRadius aReferenceBounds aNearestBounds aDirectionVector |
	
	aReferenceBounds := self referenceElement boundsInSpace.
	aNearestBounds := self nearestToElement boundsInSpace.
	
	aDirectionVector := (aNearestBounds center - aReferenceBounds center) asBlocVector.
	aRadius := (((aReferenceBounds width raisedTo: 2) + (aReferenceBounds width raisedTo: 2)) sqrt / 2.0) min: aDirectionVector length.
	
	aDirectionVector := (aDirectionVector length isZero)
		ifTrue: [ BlVector x: 1 y: 0 ]
		ifFalse: [ aDirectionVector normalized ].

	^ aReferenceBounds center + (aDirectionVector * aRadius) asPoint