accessing
borderBounds
	^ self owner geometryBounds insetBy: (self owner border stroke width -1) asFloat