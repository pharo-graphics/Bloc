Class {
	#name : #BlLayoutNonLeafChildNode,
	#superclass : #BlAbstractLayoutChildNode,
	#instVars : [
		'childNode'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutNonLeafChildNode >> childNode: aBlLayoutChildNode [

	childNode := aBlLayoutChildNode
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> children [
	^ { childNode }
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> constraints [
	^ childNode constraints
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> constraints: aBlLayoutConstraints [
	childNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutNonLeafChildNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ childNode extent
]

{ #category : #'api - geometry' }
BlLayoutNonLeafChildNode >> layoutBounds [
	<return: #BlBounds>

	^ childNode layoutBounds
]

{ #category : #'api - measure' }
BlLayoutNonLeafChildNode >> measure: anExtentSpecOrBlock [

	childNode measure: anExtentSpecOrBlock
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> measurement: aBlLayoutNodeMeasurement [
	childNode measurement: aBlLayoutNodeMeasurement
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> parent [
	<return: #BlLayoutParentNode>

	^ childNode parent
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> parent: aBlLayoutParentNode [
	childNode parent: aBlLayoutParentNode
]

{ #category : #'api - actions' }
BlLayoutNonLeafChildNode >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ childNode popAction
]

{ #category : #'api - geometry' }
BlLayoutNonLeafChildNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ childNode position
]

{ #category : #'api - geometry' }
BlLayoutNonLeafChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	childNode position: aPoint
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> privateMeasurement [

	^ childNode privateMeasurement
]

{ #category : #'api - actions' }
BlLayoutNonLeafChildNode >> pushAction: aBlLayoutNodeElementAction [

	childNode pushAction: aBlLayoutNodeElementAction
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> transformationDo: aBlock [

	childNode transformationDo: aBlock
]

{ #category : #accessing }
BlLayoutNonLeafChildNode >> userData [
	<return: #Dictionary>
	
	^ childNode userData
]

{ #category : #converting }
BlLayoutNonLeafChildNode >> withElement: aBlElement [
	^ BlLayoutChildNodeWithElement new
		childNode: self;
		element: aBlElement
]
