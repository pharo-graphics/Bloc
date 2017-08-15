private
buildElevationTree: anElement
	| elevationTree renderingNode elevationLayer |
	
	elevationTree := BlCompositorElevationTree new.
	elevationLayer := elevationTree layerAt: (anElement elevation relatedTo: 0).
	
	renderingNode := BlCompositorRenderingNode new.
	renderingNode element: anElement.
	
	elevationLayer nodes push: renderingNode.
	
	self buildElevation: renderingNode layer: elevationLayer tree: elevationTree.
	
	^ elevationTree