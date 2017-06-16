visual bounds
strokedBounds: aBlBounds of: anElement on: aCanvas
	"Return stroked bounds of a geometry if it would be stroked
	according to element's border configuration.
	Dispatch through border's BlStrokeType first"
	<return: #BlBounds>

	^ anElement outskirts strokedBounds: aBlBounds of: anElement on: aCanvas