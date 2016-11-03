as yet unclassified
backgroundColor: anBlColorValue
	anBlColorValue ifNil: [ ^ self styleable background: Color transparent ].
	self styleable background: anBlColorValue value