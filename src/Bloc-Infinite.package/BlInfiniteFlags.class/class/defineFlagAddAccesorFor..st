private - instance code
defineFlagAddAccesorFor: flagName
	| code |
	
	code := 'add', flagName, '
	"This method was automatically generated"
	value := value | ', flagName, ' value'.

	self 
		compile: code 
		classified: self generatedFlagsAddProtocolName