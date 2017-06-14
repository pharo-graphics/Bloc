geometry
windowExtent
	"Return current window extent in pixels as a Point.
	Note, that window extent is different from canvasExtent
	and is normally x2 smaller on retina screens"
	<return: #Point>

	^ self hostSpace windowExtent