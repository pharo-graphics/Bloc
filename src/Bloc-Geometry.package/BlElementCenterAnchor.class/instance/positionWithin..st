geometry
positionWithin: aGeometryElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	
	^ aGeometryElement
		firstCommonParent: self referenceElement
		ifFound: [ :aCommonParent | ((self referenceElement bounds inParent: aCommonParent) inChild: aGeometryElement) inParent center ]
		ifNone: [ 0@0 ]