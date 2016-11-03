grammar value
functionToken
	^ super functionToken
		==>
			[ :nodes | 
			| val funct args |
			val := nodes parsedValue.
			funct := val first.
			args := val second.
			self perform: ('helper' , funct asCamelCase) asSymbol asMutator with: args ]