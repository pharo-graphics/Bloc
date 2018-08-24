"
I am an elevation layer playing a role of a node in elevation tree.

I contain a forest of ==BlCompositorRenderingNode== with the same elevation
"
Class {
	#name : #BlCompositorElevationLayer,
	#superclass : #BlCompositorLayer,
	#traits : 'TBlRedBlackTreeNode',
	#classTraits : 'TBlRedBlackTreeNode classTrait',
	#instVars : [
		'color',
		'left',
		'parent',
		'right',
		'elevation',
		'nodes'
	],
	#category : 'Bloc-Compositor'
}

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> color [
	"Return node color as a symbol. Can be #black or #red"
	<return: #Symbol>
	
	^ color
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> color: aSymbol [
	"Set the color of this node. Can be #black or #red"
	
	color := aSymbol
]

{ #category : #drawing }
BlCompositorElevationLayer >> drawOnSpartaCanvas: aCanvas [

	self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aCanvas ]
]

{ #category : #accessing }
BlCompositorElevationLayer >> elevation [
	<return: #Number>

	^ elevation
]

{ #category : #accessing }
BlCompositorElevationLayer >> elevation: aNumber [
	elevation := aNumber
]

{ #category : #initialization }
BlCompositorElevationLayer >> initialize [
	super initialize.
	
	nodes := Stack new
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> key [
	<return: #TComparable>

	^ self elevation
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> left [
	"Return a left red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ left
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> left: aRedBlackNode [
	"Set my left node to a given one"
	
	left := aRedBlackNode
]

{ #category : #accessing }
BlCompositorElevationLayer >> nodes [
	^ nodes
]

{ #category : #accessing }
BlCompositorElevationLayer >> nodesAt: aPoint in: aCollection [
	self nodes
		reverseDo: [ :aNode | aNode nodesAt: aPoint in: aCollection ]
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> parent [
	"Return a parent red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ parent
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> parent: aRedBlackTreeNode [
	"Assign a given node as my parent.
	aRedBlackTreeNode must not be nil"

	parent := aRedBlackTreeNode
]

{ #category : #printing }
BlCompositorElevationLayer >> printOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self elevation asString;
		nextPut: $)
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> right [
	"Return a right red-black node"
	<return: #TBlRedBlackTreeNode>
	
	^ right
]

{ #category : #'tree - accessing' }
BlCompositorElevationLayer >> right: aRedBlackNode [
	"Set my right node to a given one"
	
	right := aRedBlackNode
]
