geometry
positionWithin: aGeometryElement
	"Compute and return a position of this anchor in parent coordinates of the *anchor* element
	taking into account a given geometry element"
	<return: #Point>

	^ aGeometryElement
		firstCommonParent: self referenceElement
		ifFound: [ :aCommonParent | self positionWithinBounds: ((self referenceElement bounds inParent: aCommonParent) inChild: aGeometryElement) inParent ]
		ifNone: [ 0@0 ]