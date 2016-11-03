as yet unclassified
borderColor: aBlColorValue
	self styleable border: (BlBorder stroke:
					(self styleable border stroke
						copyWithColor: (aBlColorValue value ifNil: [ Color transparent ])))