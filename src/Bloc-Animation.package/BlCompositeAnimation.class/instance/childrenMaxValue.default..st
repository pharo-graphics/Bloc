private
childrenMaxValue: aBlock default: aValue
	| max |
	self animations ifEmpty: [ ^ aValue ].
	max := aBlock value: self animations first.
	self animations
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			max := max max: value ].
	^ max