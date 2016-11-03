accessing
borderBounds
	^ self owner geomBounds insetBy: (self owner border stroke width -1) asFloat