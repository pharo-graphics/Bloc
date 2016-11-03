as yet unclassified
invalidate
	isValid ifTrue: [ 
		isValid := false.
		self notifyValueChanged ]