grammar value
arrayToken
	^ super arrayToken
		==>
			[ :nodes | BlArrayValue value: (nodes parsedValue first collect: [ :item | item value ]) ]