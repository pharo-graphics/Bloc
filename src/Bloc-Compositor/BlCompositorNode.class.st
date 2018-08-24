"
I am a rendering node of a compositor layer.
"
Class {
	#name : #BlCompositorNode,
	#superclass : #Object,
	#instVars : [
		'parent',
		'element',
		'transformation',
		'nodes'
	],
	#category : 'Bloc-Compositor'
}

{ #category : #accessing }
BlCompositorNode >> addNode: aRenderingNode [

	nodes add: aRenderingNode.	
	aRenderingNode parent: self
]

{ #category : #converting }
BlCompositorNode >> asDoubleLink [
	<return: #DoubleLink>

	^ BlCompositorNodeLink value: self
]

{ #category : #drawing }
BlCompositorNode >> drawOnSpartaCanvas: aCanvas [
	
	aCanvas transform
		by: self transformation
		translated: 0 @ 0
		during: [ :aTransformedCanvas |
			aTransformedCanvas transform
				by: self element transformation
				translated: self element position
				during: [ :aMoreTransformedCanvas |
					self element drawOnSpartaCanvas: aMoreTransformedCanvas.
					self hasNodes
						ifTrue: [ self nodes reverseDo: [ :aNode | aNode drawOnSpartaCanvas: aMoreTransformedCanvas ] ] ] ]
]

{ #category : #accessing }
BlCompositorNode >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlCompositorNode >> element: anElement [
	element := anElement
]

{ #category : #testing }
BlCompositorNode >> hasNodes [
	<return: #Boolean>

	^ self nodes isNotEmpty
]

{ #category : #initialization }
BlCompositorNode >> initialize [
	super initialize.
	
	nodes := LinkedList new.
	transformation := BlElementAbsoluteTransformation new
]

{ #category : #accessing }
BlCompositorNode >> nodes [
	"Return children nodes of this node"
	<return: #LinkedList of: #BlCompositorNode>

	^ nodes
]

{ #category : #'collecting nodes' }
BlCompositorNode >> nodesAt: aPoint in: aCollection [
	| aParentPoint aLocalPoint |

	aParentPoint := self transformation inverseTransformPoint: aPoint.
	aLocalPoint := self element parentPointToLocal: aParentPoint.
	
	(self element containsPoint: aLocalPoint)
		ifTrue: [ aCollection addFirst: self ].
		
	self nodes reverseDo: [ :aNode | aNode nodesAt: aPoint in: aCollection ]
]

{ #category : #accessing }
BlCompositorNode >> parent [
	<return: #BlCompositorNode>

	^ parent
]

{ #category : #accessing }
BlCompositorNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
BlCompositorNode >> transformation [
	"Return a transformation"
	<return: #BlElementTransformation>

	^ transformation
]

{ #category : #accessing }
BlCompositorNode >> transformation: aBlMatrix [
	transformation := aBlMatrix
]
