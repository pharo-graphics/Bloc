as yet unclassified
borderWidth: anBlValue
	self styleable border: (BlBorder stroke:
					(self styleable border stroke copyWithWidth: (anBlValue value ifNil: [ 0 ])))