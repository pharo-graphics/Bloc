host space - accessing
scaleFactor
	"Return a scaling factor from space to window coordinates.
	On high dpi (retina) displays scaling factor is > 1"
	<return: #Point>
	
	^ self canvasExtent / self windowExtent