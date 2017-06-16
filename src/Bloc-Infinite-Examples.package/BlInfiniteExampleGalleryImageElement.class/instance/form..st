accessing
form: aForm
	
	image form == aForm
		ifFalse: [ ^ self ].
	
	self
		assert: [ image form == aForm ]
		description: [ 'Form must belong to current image' ].

	form := aForm.
	bitmap := nil.
	self requestLayout.
	self invalidate