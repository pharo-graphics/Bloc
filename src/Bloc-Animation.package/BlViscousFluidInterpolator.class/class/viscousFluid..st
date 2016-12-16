interpolation
viscousFluid: aNumber
	| value |
	value := aNumber * FluidScale.
	value < 1.0
		ifTrue: [ value := value - (1.0 - value negated exp) ]
		ifFalse: [ 
			value := 1.0 - (1.0 - value) exp.
			value := InvertedExponent + (value * ( 1.0 - InvertedExponent)) ].
	^ value