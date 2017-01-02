drawing
drawOnSpartaCanvas: aCanvas
	| aRenderer |
	super drawOnSpartaCanvas: aCanvas.

	"Text layout is not yet measured, nothing to render"
	textLayout
		ifNil: [ ^ self ].

	aRenderer := textLayout rendererOn: aCanvas.
	aRenderer offset: (self constraints padding left @ self constraints padding top).
	aRenderer renderOn: aCanvas