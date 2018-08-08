icon
categoryIconFor: aString
	<return: #Form>
	| thePragmas |
	
	thePragmas := Pragma
		allNamed: #nautilusProtocolIcon:
		from: self class
		to: Object
		sortedByArgument: 1.
		
	thePragmas do: [ :aPragma |
		| aValueHolder |
		aValueHolder := ValueHolder new.
		aPragma method
			valueWithReceiver: aPragma methodClass
			arguments: { aString . aValueHolder }.
		aValueHolder contents
			ifNotNil: [ ^ aValueHolder contents ] ].

	^ self iconNamed: #protocolNoneIcon