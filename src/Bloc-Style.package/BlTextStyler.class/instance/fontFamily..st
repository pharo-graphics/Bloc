as yet unclassified
fontFamily: anBlValue
	self styleable
		font: (LogicalFont familyName: (anBlValue value ifNil: [ StandardFonts defaultFont familyName ]) pointSize: self styleable font pointSize)