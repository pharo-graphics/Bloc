drawing
drawArrowHeadsOnSpartaCanvas: aCanvas

	self hasFromHead
		ifTrue: [ self fromHead fullDrawOnSpartaCanvas: aCanvas ].
	self hasToHead
		ifTrue: [ self toHead fullDrawOnSpartaCanvas: aCanvas ]