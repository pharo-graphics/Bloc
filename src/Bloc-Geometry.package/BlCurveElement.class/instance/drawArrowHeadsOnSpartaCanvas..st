drawing
drawArrowHeadsOnSpartaCanvas: aCanvas

	aCanvas
		compose: #composeSource
		during: [
			self hasFromHead
				ifTrue: [ self fromHead fullDrawOnSpartaCanvas: aCanvas ].
			self hasToHead
				ifTrue: [ self toHead fullDrawOnSpartaCanvas: aCanvas ] ]