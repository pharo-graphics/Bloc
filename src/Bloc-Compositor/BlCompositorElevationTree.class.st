"
I am a red-black binary tree of ===BlCompositorElevationLayer=== ordered by elevation.

I am used by ===BlCompositor=== in order to render layers in the right order based on their elevation.
"
Class {
	#name : #BlCompositorElevationTree,
	#superclass : #Object,
	#traits : 'TBlRedBlackTree',
	#classTraits : 'TBlRedBlackTree classTrait',
	#instVars : [
		'root'
	],
	#category : 'Bloc-Compositor'
}

{ #category : #drawing }
BlCompositorElevationTree >> drawOnSpartaCanvas: aCanvas [

	self do: [ :aLayer | aLayer drawOnSpartaCanvas: aCanvas ]
]

{ #category : #accessing }
BlCompositorElevationTree >> layerAt: anElevation [
	"Search for an Elevataion layer and return if found or create a new one otherwise"
	<return: #BlCompositorElevationLayer>
	
	^ self
		at: anElevation
		ifAbsentPut: [	self newLayer elevation: anElevation ]
]

{ #category : #'instance creation' }
BlCompositorElevationTree >> newLayer [
	"Return a new instance of elevation layer to be created during #layerAt:"
	<return: #BlCompositorElevationLayer>
	
	^ BlCompositorElevationLayer new
]

{ #category : #accessing }
BlCompositorElevationTree >> nodesAt: aPoint [
	"Return a collection of rendering nodes located at a given point in space coordinates"
	| theNodes |
	
	theNodes := DoubleLinkedList new.
	self do: [ :aLayer | aLayer nodesAt: aPoint in: theNodes ].
	^ theNodes
]

{ #category : #'tree - accessing' }
BlCompositorElevationTree >> root [
	"Return my root node"
	<return: #TBlRedBlackTreeNode>
	
	^ root
]

{ #category : #'tree - accessing' }
BlCompositorElevationTree >> root: aRedBlackNode [
	"Change my root node to the given one"
	
	root := aRedBlackNode
]
