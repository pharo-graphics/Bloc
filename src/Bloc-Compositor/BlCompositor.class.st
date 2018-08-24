Class {
	#name : #BlCompositor,
	#superclass : #Object,
	#instVars : [
		'rootElement'
	],
	#category : 'Bloc-Compositor'
}

{ #category : #'instance creation' }
BlCompositor class >> on: anElement [

	^ self new initializeWith: anElement
]

{ #category : #private }
BlCompositor >> buildElevation: aRenderingNode layer: anElevationLayer tree: aCompositorTree [
	| aLayerElevation |

	aLayerElevation := anElevationLayer elevation.

	aRenderingNode element childrenDo: [ :aChildElement |
		| aChildNode aChildElevation aChildLayer |
		
		aChildElevation := aChildElement elevation relatedTo: aLayerElevation.
		
		aChildNode := BlCompositorNode new.
		aChildNode element: aChildElement.
		
		(aChildElevation = aLayerElevation)
			"elevation is the same, add child node to the rendering node in the same layer"
			ifTrue: [
				aRenderingNode addNode: aChildNode.
				aChildLayer := anElevationLayer ]
			"elevation is not the same, find a corresponding layer or create a new one"
			ifFalse: [ 
				aChildElement hasParent
					ifTrue: [
						aChildNode transformation: aChildElement parent transformation inSpace ].
				aChildLayer := aCompositorTree layerAt: aChildElevation.
				aChildLayer nodes push: aChildNode ].
		
		self buildElevation: aChildNode layer: aChildLayer tree: aCompositorTree ]
]

{ #category : #private }
BlCompositor >> buildElevationTree: anElement [
	| elevationTree renderingNode elevationLayer |
	
	elevationTree := BlCompositorElevationTree new.
	elevationLayer := elevationTree layerAt: (anElement elevation relatedTo: 0).
	
	renderingNode := BlCompositorNode new.
	renderingNode element: anElement.
	
	elevationLayer nodes push: renderingNode.
	
	self buildElevation: renderingNode layer: elevationLayer tree: elevationTree.
	
	^ elevationTree
]

{ #category : #drawing }
BlCompositor >> drawOnSpartaCanvas: aCanvas [
	| elevationTree |
	
	elevationTree := self buildElevationTree: rootElement.
	elevationTree drawOnSpartaCanvas: aCanvas
]

{ #category : #initialization }
BlCompositor >> initializeWith: anElement [
	rootElement := anElement
]
