helper
helperRgba: args
	args first value isColor
		ifTrue: [ ^ BlColorValue value: (args first value alpha: args last value) ]