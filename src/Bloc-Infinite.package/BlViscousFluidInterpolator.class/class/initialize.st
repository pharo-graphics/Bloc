initialization
initialize
	super initialize.
	
	InvertedExponent := 1.0 / Float e.
	"Controls the viscous fluid effect (how much of it)"
	FluidScale := 8.0.
	"must be set to 1.0 (used in viscousFluid())"
	FluidNormalize := 1.0 / (self viscousFluid: 1.0).
	"account for very small floating-point error"
	FluidOffset := 1.0 - (FluidNormalize * (self viscousFluid: 1.0))