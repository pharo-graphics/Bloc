private - instance code
defineFlagClearAccesorFor: flagName
	| code |
	
	code := 'clear', flagName, '
	"This method was automatically generated"
	value := value & (', flagName, ' value bitInvert)'.

	self 
		compile: code 
		classified: self generatedFlagsClearProtocolName