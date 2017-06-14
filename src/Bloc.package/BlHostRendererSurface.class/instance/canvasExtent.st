geometry
canvasExtent
	"Return current canvas extent in pixels as a Point.
	Note, that canvas extent is different from windowExtent
	and is normally x2 bigger on retina screens"
	<return: #Point>

	^ self hostSpace canvasExtent