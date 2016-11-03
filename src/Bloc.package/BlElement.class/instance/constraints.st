accessing
constraints
	"Return element constraints object which is used by the layout strategy.
	constraints can not be nil.
	@see BlElement>>#constraintsDo: for more convenient method to update element constraints,
	as it requests layout update."
	<return: #BlElementConstraints>
	self assert: constraints isNotNil.
	^ constraints