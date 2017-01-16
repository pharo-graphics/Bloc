accessing
form: aForm
	
	self
		assert: [ image form == aForm ]
		description: [ 'Form must belong to current image' ].

	form := aForm.
	self requestLayout.
	self invalidate