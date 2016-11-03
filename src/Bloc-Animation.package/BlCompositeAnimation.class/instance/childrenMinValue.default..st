private
childrenMinValue: aBlock default: aValue
	| min |
	self children ifEmpty: [ ^ aValue ].
	min := (aBlock value: self children first) max: 0.
	self children
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			min := min min: value ].
	^ min