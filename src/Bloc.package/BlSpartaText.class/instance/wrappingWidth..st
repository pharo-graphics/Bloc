text wrapping
wrappingWidth: aNumber
	wrappingWidth := aNumber.
	aNumber > 0
		ifTrue: [ wrapAttribute wordWrap. layoutView maxWidth: wrappingWidth]
		ifFalse: [ wrapAttribute none layoutView maxWidth: Float infinity].
	self wrappingChanged