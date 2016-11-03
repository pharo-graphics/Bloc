text wrapping
wrappingWidth: aNumber
	wrappingWidth := aNumber.
	aNumber > 0
		ifTrue: [ wrapAttribute wordWrap ]
		ifFalse: [ wrapAttribute none ].
	self wrappingChanged