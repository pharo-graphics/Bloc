drawing
drawOnSpartaCanvas: aCanvas
	super drawOnSpartaCanvas: aCanvas.

	"Text layout is not yet measured, nothing to render"
	textLayout
		ifNil: [ ^ self ].
		
	aCanvas transform during: [ :aTransformation |
		aTransformation
			translateBy: self constraints padding left @ self constraints padding top;
			apply.
		textLayout renderOn: aCanvas ]