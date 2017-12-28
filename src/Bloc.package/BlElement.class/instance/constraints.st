private - accessing
constraints
	"Return layout constraints object which is used by the layout strategy.
	constraints can not be nil.
	@see BlElement>>#constraintsDo: for more convenient method to update constraints,
	as it requests layout update."
	<return: #BlLayoutConstraints>

	^ constraints