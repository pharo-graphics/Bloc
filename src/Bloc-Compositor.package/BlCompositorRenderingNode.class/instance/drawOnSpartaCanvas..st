drawing
drawOnSpartaCanvas: aCanvas

	self element drawOnSpartaCanvas: aCanvas.
	self hasNodes
		ifTrue: [ self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aCanvas ] ]