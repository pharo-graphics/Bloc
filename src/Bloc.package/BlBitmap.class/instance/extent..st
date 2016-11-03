as yet unclassified
extent: anExtent
	|scaledForm|
	scaledForm := form magnifyBy: (anExtent/form extent) min asFloat.
	self background: (BlImagePatternPaint new form: scaledForm).
	super extent: scaledForm extent.