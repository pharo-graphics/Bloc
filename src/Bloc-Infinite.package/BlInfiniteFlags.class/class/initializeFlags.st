initialization
initializeFlags

	self flagsDictionary keysAndValuesDo: [ :eachName :eachValue | 
		| classBinding flagValue |
		
		flagValue := eachValue.
		classBinding := self classPool associationAt: eachName asSymbol ifAbsent: [ nil ].
		classBinding 
			ifNotNil: [ classBinding value: flagValue ]
			ifNil: [ 
				self classPool add: (ClassVariable 
					key: eachName asSymbol 
					value: flagValue ) ] ]