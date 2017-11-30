drawing
drawOnSpartaCanvas: aCanvas
	"Override to avoid creation of new layers"

	self outskirts
		drawBackground: [ self drawBackgroundOnSpartaCanvas: aCanvas ]
		border: [ self drawBorderOnSpartaCanvas: aCanvas ]
		of: self
		onSpartaCanvas: aCanvas