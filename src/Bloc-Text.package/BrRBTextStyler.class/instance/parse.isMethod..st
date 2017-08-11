private
parse: aText isMethod: isMethod
	|root aString |
	
	aString := aText asString.
	
	isMethod 
		ifTrue: [
			[root := RBParser parseFaultyMethod: aString.
			root methodNode methodClass: classOrMetaClass.
			^root] 
				on: Error 
				do: [^RBParser parseFaultyExpression: aString ]]
		ifFalse:[ ^RBParser parseFaultyExpression: aString ].