accessing
form: aForm
	
	image form == aForm
		ifFalse: [ ^ self ].
	
	self
		assert: [ image form == aForm ]
		description: [ 'Form must belong to current image' ].

	form := aForm.
	self requestLayout.
	self invalidate