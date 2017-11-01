drawing
drawOnSpartaCanvas: aCanvas
	
	aCanvas transform
		by: self transformation
		translated: 0 @ 0
		during: [ :aTransformedCanvas |
			aTransformedCanvas transform
				by: self element transformation
				translated: self element position
				during: [ :aMoreTransformedCanvas |
					self element drawOnSpartaCanvas: aMoreTransformedCanvas.
					self hasNodes
						ifTrue: [ self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aMoreTransformedCanvas ] ] ] ]