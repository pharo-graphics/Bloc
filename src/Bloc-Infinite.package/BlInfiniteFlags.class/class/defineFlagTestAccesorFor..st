private - instance code
defineFlagTestAccesorFor: flagName
	| code |
	
	code := 'has', flagName, '
	"This method was automatically generated"
	^ (value & ', flagName, ' value) ~= 0'.

	self 
		compile: code 
		classified: self generatedFlagsTestingProtocolName