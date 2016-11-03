private
childrenMaxValue: aBlock default: aValue
	| max |
	self children ifEmpty: [ ^ aValue ].
	max := aBlock value: self children first.
	self children
		allButFirstDo:
			[ :each | 
			| value |
			value := aBlock value: each.
			max := max max: value ].
	^ max