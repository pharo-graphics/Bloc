Class {
	#name : 'BlLayoutChildNode',
	#superclass : 'BlLayoutNode',
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'parent',
		'measurement',
		'layoutBounds',
		'constraints',
		'userData',
		'actions'
	],
	#category : 'Bloc-Layouts-Model',
	#package : 'Bloc',
	#tag : 'Layouts-Model'
}

{ #category : 'accessing' }
BlLayoutChildNode >> children [
	^ #()
]

{ #category : 'accessing' }
BlLayoutChildNode >> constraints [
	^ constraints
]

{ #category : 'accessing' }
BlLayoutChildNode >> constraints: aBlLayoutConstraints [
	constraints := aBlLayoutConstraints
]

{ #category : 'api - geometry' }
BlLayoutChildNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ measurement extent
]

{ #category : 'initialization' }
BlLayoutChildNode >> initialize [
	super initialize.
	
	measurement := BlLayoutNodeNullMeasurement new.
	parent := nil.
	userData := nil.
	actions := Stack new
]

{ #category : 'api - geometry' }
BlLayoutChildNode >> layoutBounds [
	<return: #BlBounds>

	^ BlBounds
		origin: self position
		extent: measurement extent
]

{ #category : 'api - measure' }
BlLayoutChildNode >> measure: anExtentSpecOrBlock [
	measurement := measurement measure: self with: anExtentSpecOrBlock
]

{ #category : 'accessing' }
BlLayoutChildNode >> measurement: aBlLayoutNodeMeasurement [
	measurement := aBlLayoutNodeMeasurement
]

{ #category : 'accessing' }
BlLayoutChildNode >> parent [
	^ parent
]

{ #category : 'accessing' }
BlLayoutChildNode >> parent: anObject [
	parent := anObject
]

{ #category : 'api - actions' }
BlLayoutChildNode >> popAction [
	<return: #BlLayoutNodeElementAction or: #nil>

	^ actions
		ifEmpty: [ nil ]
		ifNotEmpty: [ :theActions | theActions pop ]
]

{ #category : 'api - geometry' }
BlLayoutChildNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ measurement position
]

{ #category : 'api - geometry' }
BlLayoutChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	measurement position: aPoint
]

{ #category : 'printing' }
BlLayoutChildNode >> printOn: aStream [
	aStream
		nextPutAll: 'Node position: ';
		print: measurement position;
		nextPutAll: ' extent: ';
		print: measurement extent
]

{ #category : 'accessing' }
BlLayoutChildNode >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ measurement
]

{ #category : 'api - actions' }
BlLayoutChildNode >> pushAction: aBlLayoutNodeElementAction [
	actions push: aBlLayoutNodeElementAction
]

{ #category : 'accessing' }
BlLayoutChildNode >> transformationDo: aBlock [
]

{ #category : 'accessing' }
BlLayoutChildNode >> userData [
	<return: #Dictionary>
	
	^ userData ifNil: [ userData := Dictionary new ]
]

{ #category : 'converting' }
BlLayoutChildNode >> withEdges: aCollectionOfLayoutEdges [
	^ BlLayoutChildNodeWithEdges new
		childNode: self;
		connectedEdges: aCollectionOfLayoutEdges
]

{ #category : 'converting' }
BlLayoutChildNode >> withElement: aBlElement [
	^ BlLayoutChildNodeWithElement new
		childNode: self;
		element: aBlElement
]

{ #category : 'converting' }
BlLayoutChildNode >> withMatrix: aBlMatrix [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		matrix:  aBlMatrix
]

{ #category : 'converting' }
BlLayoutChildNode >> withTransformation: aBlElementTransformation [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		transformation:  aBlElementTransformation
]

{ #category : 'converting' }
BlLayoutChildNode >> withoutElement [
	"Return a layout node that does not know the element"
	<return: #BlLayoutChildNode>

	^ self
]

{ #category : 'converting' }
BlLayoutChildNode >> withoutTransformation [
	^ self
]
