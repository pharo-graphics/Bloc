accessing
form: aForm
	form := aForm.
	
	self defer: [ self changed ]