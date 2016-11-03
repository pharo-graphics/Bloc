as yet unclassified
form: aForm
	form := aForm.
	super extent: aForm extent.
	self background: (BlImagePatternPaint new form: form)