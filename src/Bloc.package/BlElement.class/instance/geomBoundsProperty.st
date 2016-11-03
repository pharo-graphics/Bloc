accessing properties
geomBoundsProperty
	^ geomBounds
		ifNil: [ geomBounds := BlBoundsProperty
				on: self
				named: #geomBounds
				compute: [ self computeGeomBounds ] ]