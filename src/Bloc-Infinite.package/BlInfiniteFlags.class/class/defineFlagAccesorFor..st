private - class code
defineFlagAccesorFor: flagName
	"Define accessors as class methods"
	| code |
	
	code := flagName, '
	"This method was automatically generated"
	^ ', flagName, ' value'.
	
	self class 
		compile: code 
		classified: self generatedFlagsProtocolName.