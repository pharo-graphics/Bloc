grammar value
identToken
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(self colorClass respondsTo: val)
				ifTrue: [ BlColorValue value: (self colorClass perform: val) ]
				ifFalse: [ BlSymbolValue value: val ] ]