layout
layoutBounds
	"Compute and return layout bounds based on geometry anchors.
	The bounds origin describes a position of this geometry element
	within its parent, while bounds extent describes my extent"
	<return: #Rectangle>
	
	^ self subclassResponsibility