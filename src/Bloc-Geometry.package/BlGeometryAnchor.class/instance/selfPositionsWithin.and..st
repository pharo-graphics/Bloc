geometry
selfPositionsWithin: aGeometryElement and: anAnotherAnchor
	<return: #Collection of: #Point>
	
	^ (self globalSelfPositionsWithin: aGeometryElement and: anAnotherAnchor)
			collect: [ :aPoint | aGeometryElement globalPointToParent: aPoint ]