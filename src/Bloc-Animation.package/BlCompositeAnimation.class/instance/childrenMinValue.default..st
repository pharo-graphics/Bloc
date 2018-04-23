private
childrenMinValue: aBlock default: aValue
	| min |
	self animations ifEmpty: [ ^ aValue ].
	min := (aBlock value: self animations first) max: 0 seconds.
	self animations
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			min := min min: value ].
	^ min