accessing
form: aForm
	
	form := aForm.
	
	defered
		ifTrue: [ ^ self ].
	 
	defered := true.
	self defer: [
		defered := false.
		self changed ]