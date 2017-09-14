path commands
convertToAbsolutePoint: aPoint
	^ self ifRelative: [ previousPoint + aPoint ] ifAbsolute: [ aPoint ]