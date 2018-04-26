geometry bounds
visualBounds
	"Visual bounds represent a high precision area of rendered geometry, including border.
	By default, visual bounds of `inside` outskits equal to geometry bounds since border
	is never rendered outside of the element's geometry.
	Note: When there is no sparta canvas available, return geometry bounds"
	
	^ Bloc hasSparta
		ifTrue: [ self visualBoundsOn: (Bloc preferableSpartaCanvas offscreen) ]
		ifFalse: [ self geometryBounds ]