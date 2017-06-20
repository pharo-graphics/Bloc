renderer - testing
supportsFormSurface
	"Return true if this renderer can work with form surface, false otherwise"
	<return: #Boolean>
	
	^ self class defaultCanvasBuilder class supportsFormSurface