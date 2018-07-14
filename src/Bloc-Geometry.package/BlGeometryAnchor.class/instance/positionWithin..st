geometry
positionWithin: aGeometryElement
	"Compute and return a position of this anchor in parent coordinates of the *anchor* element
	taking into account a given geometry element"
	<return: #Point>

	^ self computedPosition
		ifNil: [ computedPosition := self computePositionWithin: aGeometryElement ]