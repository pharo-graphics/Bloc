geometry
positionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	
	true ifTrue: [ ^ super positionWithin: aGeometryElement ].
	
	^ aGeometryElement
		firstCommonParent: self referenceElement
		ifFound: [ :aCommonParent |
			| aReferenceBounds |
			
			aReferenceBounds := (self referenceElement bounds inParent: aCommonParent) inChild: aGeometryElement.

			"aParent localBoundsToMine: aBlBounds fromChild: self referenceElement" ]
		ifNone: [ ^ 0@0 ]


	"^ self referenceElement boundsInSpace center"