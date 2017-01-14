visual bounds
strokedBounds: aSpartaRectangle of: anElement on: aCanvas
	"Return stroked bounds of geometry if it would be stroked
	according to element's border configuration.
	Dispatch through border's BlStrokeType first"
	<return: #SpartaRectangle>

	^ anElement border type strokedBounds: aSpartaRectangle of: anElement on: aCanvas