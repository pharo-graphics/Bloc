visual bounds
strokedBounds: aBounds of: anElement on: aCanvas
	"Return stroked bounds of geometry if it would be stroked
	according to element's border configuration.
	Dispatch through border's BlStrokeType first"
	<return: #BlBounds>

	^ anElement border type strokedBounds: aBounds of: anElement on: aCanvas