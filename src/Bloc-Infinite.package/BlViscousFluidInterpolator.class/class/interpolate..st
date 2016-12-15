interpolation
interpolate: aNumber
	| interpolated |
	
	interpolated := FluidNormalize * (self viscousFluid: aNumber).
	^ interpolated > 0
		ifTrue: [ interpolated + FluidOffset ]
		ifFalse: [ interpolated ]