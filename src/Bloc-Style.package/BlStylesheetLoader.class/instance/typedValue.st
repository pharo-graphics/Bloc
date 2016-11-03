grammar value
typedValue
	^ super typedValue
		==>
			[ :nodes | 
			BlStyleValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]