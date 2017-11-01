private
buildElevation: aRenderingNode layer: anElevationLayer tree: aCompositorTree
	| aLayerElevation |

	aLayerElevation := anElevationLayer elevation.

	aRenderingNode element childrenDo: [ :aChildElement |
		| aChildNode aChildElevation aChildLayer |
		
		aChildElevation := aChildElement elevation relatedTo: aLayerElevation.
		
		aChildNode := BlCompositorRenderingNode new.
		aChildNode element: aChildElement.
		
		(aChildElevation = aLayerElevation)
			"elevation is the same, add child node to the rendering node in the same layer"
			ifTrue: [
				aRenderingNode addNode: aChildNode.
				aChildLayer := anElevationLayer ]
			"elevation is not the same, find a corresponding layer or create a new one"
			ifFalse: [ 
				aChildLayer := aCompositorTree layerAt: aChildElevation.
				aChildLayer nodes push: aChildNode ].
		
		self buildElevation: aChildNode layer: aChildLayer tree: aCompositorTree ]