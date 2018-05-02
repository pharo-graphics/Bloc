private
resolveStyleFor: aVariableNode
	aVariableNode binding isUndeclared ifTrue: [
		| var |
		var := aVariableNode scope findVariable: [ :varS | varS name beginsWith: aVariableNode name ] ifNone: [ nil ].
		var ifNil: [ #default ] ifNotNil: [ #incompleteIdentifier ].
	].
	aVariableNode binding ifNil: [^#default].
	aVariableNode isArg ifTrue: [ ^#methodArg].
	aVariableNode isTemp ifTrue: [ ^#tempVar].
	aVariableNode isGlobal ifTrue: [ ^#globalVar].
	aVariableNode isInstance ifTrue: [ ^#instVar]. 
	aVariableNode hasIncompleteIdentifier ifTrue:[ ^#incompleteIdentifier].
	^#invalid.