renderer - testing
supportsBufferSurface
	"Return true if this renderer can work with buffer surface, false otherwise"
	<return: #Boolean>
	
	^ self class defaultCanvasBuilder class supportsBufferSurface