requirements
element
	^ element ifNil: [ 
		element := elementBuilder glamourValue: 
			(self asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue).
		element when: GLMBlocObjectToSelect do: [:signal | self selection: signal toSelect ] ]