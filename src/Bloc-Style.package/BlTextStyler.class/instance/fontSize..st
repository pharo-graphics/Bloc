as yet unclassified
fontSize: anBlValue
	self styleable
		font: (LogicalFont familyName: self styleable font familyName pointSize: (anBlValue value ifNil: [ StandardFonts defaultFont pointSize ]))