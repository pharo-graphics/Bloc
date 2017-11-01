drawing
drawOnSpartaCanvas: aCanvas

	self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aCanvas ]