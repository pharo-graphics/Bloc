Class {
	#name : #BlLayoutChildNode,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutChildNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutChildNode classTrait',
	#instVars : [
		'parent',
		'measurement',
		'layoutBounds',
		'constraints',
		'userData'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutChildNode >> children [
	^ #()
]

{ #category : #accessing }
BlLayoutChildNode >> constraints [
	^ constraints
]

{ #category : #accessing }
BlLayoutChildNode >> constraints: aBlLayoutConstraints [
	constraints := aBlLayoutConstraints
]

{ #category : #initialization }
BlLayoutChildNode >> initialize [
	super initialize.
	
	measurement := BlLayoutNodeNullMeasurement new.
	parent := nil.
	userData := nil
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> layoutBounds [
	<return: #BlBounds>

	^ layoutBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> layoutBounds: aBlLayoutBounds [
	self
		assert: [ aBlLayoutBounds isKindOf: BlLayoutBounds ]
		description: [ 'Must be an instance of a special layout bounds class' ].

	layoutBounds := aBlLayoutBounds inLocal asBounds
]

{ #category : #'api - measure' }
BlLayoutChildNode >> measure: anExtentSpec [
	measurement := measurement measure: self with: anExtentSpec
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ BlLayoutBoundsInLocal new
		position: self measurement position
			extent: self measurement extent
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtent>

	^ BlLayoutExtentInLocal new
		size: self measurement extent
]

{ #category : #accessing }
BlLayoutChildNode >> measurement [
	<return: #BlLayoutNodeMeasurement>

	^ measurement
]

{ #category : #accessing }
BlLayoutChildNode >> measurement: aBlLayoutNodeMeasurement [
	measurement := aBlLayoutNodeMeasurement
]

{ #category : #accessing }
BlLayoutChildNode >> parent [
	^ parent
]

{ #category : #accessing }
BlLayoutChildNode >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
BlLayoutChildNode >> printOn: aStream [
	aStream
		nextPutAll: 'Node position: ';
		print: self measurement position;
		nextPutAll: ' extent: ';
		print: self measurement extent
]

{ #category : #accessing }
BlLayoutChildNode >> userData [
	<return: #Dictionary>
	
	^ userData ifNil: [ userData := Dictionary new ]
]

{ #category : #converting }
BlLayoutChildNode >> withEdges: aCollectionOfLayoutEdges [
	^ BlLayoutChildNodeWithEdges new
		childNode: self;
		connectedEdges: aCollectionOfLayoutEdges
]

{ #category : #converting }
BlLayoutChildNode >> withElement: aBlElement [
	^ BlLayoutChildNodeWithElement new
		childNode: self;
		element: aBlElement
]

{ #category : #converting }
BlLayoutChildNode >> withMatrix: aBlMatrix [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		matrix:  aBlMatrix
]

{ #category : #converting }
BlLayoutChildNode >> withTransformation: aBlElementTransformation [
	^ BlLayoutChildNodeWithTransformation new
		childNode: self;
		transformation:  aBlElementTransformation
]

{ #category : #converting }
BlLayoutChildNode >> withoutElement [
	"Return a layout node that does not know the element"
	<return: #BlLayoutChildNode>

	^ self
]
