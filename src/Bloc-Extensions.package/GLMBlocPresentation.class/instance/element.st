requirements
element
	^ element ifNil: [ element := elementBuilder glamourValue: 
			(self asGlamorousMultiValue, 
			self displayValue asGlamorousMultiValue) ]