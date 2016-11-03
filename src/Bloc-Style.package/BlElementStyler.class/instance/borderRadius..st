as yet unclassified
borderRadius: anBlValue
	self styleable border: (BlBorder stroke:
					(self styleable border stroke copyWithRadius: (anBlValue value ifNil: [ 0 ])))