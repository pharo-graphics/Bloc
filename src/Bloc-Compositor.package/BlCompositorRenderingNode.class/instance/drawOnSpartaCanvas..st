drawing
drawOnSpartaCanvas: aCanvas
	
	aCanvas transform
		by: self element transformation
		translated: self element position
		during: [ :aTransformedCanvas |
			self element drawOnSpartaCanvas: aCanvas.
			self hasNodes
				ifTrue: [ self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aCanvas ] ] ]