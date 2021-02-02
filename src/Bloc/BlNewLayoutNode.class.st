Class {
	#name : #BlNewLayoutNode,
	#superclass : #Object,
	#type : #variable,
	#traits : 'TBlNewLayoutNodeWithConstraints + TBlNewLayoutCompositeNode + TBlNewLayoutNode',
	#classTraits : 'TBlNewLayoutNodeWithConstraints classTrait + TBlNewLayoutCompositeNode classTrait + TBlNewLayoutNode classTrait',
	#instVars : [
		'constraints',
		'decoration',
		'parent',
		'children',
		'measurement',
		'userData',
		'actions',
		'extentSpec'
	],
	#category : #'Bloc-Layouts-Model-New'
}

{ #category : #accessing }
BlNewLayoutNode >> children [
	<return: #Collection of: #BlLayoutNode>

	^ children
]

{ #category : #accessing }
BlNewLayoutNode >> children: aCollectionOfChildNodes [
	children := aCollectionOfChildNodes as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlNewLayoutNode >> childrenDo: aBlock [
	self children do: aBlock
]

{ #category : #accessing }
BlNewLayoutNode >> constraints [
	^ constraints
]

{ #category : #accessing }
BlNewLayoutNode >> constraints: aBlLayoutConstraints [
	constraints := aBlLayoutConstraints
]

{ #category : #accessing }
BlNewLayoutNode >> decoration [
	^ decoration
]

{ #category : #'api - geometry' }
BlNewLayoutNode >> extent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>

	^ decoration getExtentOf: self
]

{ #category : #'api - extent spec' }
BlNewLayoutNode >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ extentSpec
]

{ #category : #'api - extent spec' }
BlNewLayoutNode >> extentSpec: aBlExtentMeasurementSpec [
	extentSpec := aBlExtentMeasurementSpec
]

{ #category : #ui }
BlNewLayoutNode >> gtChildrenFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Children';
		priority: 5;
		object: [ self children ];
		view: #gtChildrenFor:
]

{ #category : #initialization }
BlNewLayoutNode >> initialize [
	super initialize.
	
	decoration := BlNewLayoutNodeNoDecoration new.
	measurement := BlLayoutNodeNullMeasurement new.
	userData := nil
]

{ #category : #'api - geometry' }
BlNewLayoutNode >> layoutBounds [
	<return: #BlBounds>

	^ decoration getLayoutBoundsOf: self
]

{ #category : #'api - measure' }
BlNewLayoutNode >> measure: anExtentSpecOrBlock [
	decoration measure: anExtentSpecOrBlock of: self
]

{ #category : #accessing }
BlNewLayoutNode >> measurement: aBlLayoutNodeMeasurement [
	measurement := aBlLayoutNodeMeasurement
]

{ #category : #accessing }
BlNewLayoutNode >> parent [
	<return: #BlLayoutParentNode>

	^ parent
]

{ #category : #accessing }
BlNewLayoutNode >> parent: aBlLayoutParentNode [
	parent := aBlLayoutParentNode
]

{ #category : #'api - geometry' }
BlNewLayoutNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ decoration getPositionOf: self
]

{ #category : #'api - geometry' }
BlNewLayoutNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	
	decoration setPosition: aPoint of: self
]

{ #category : #private }
BlNewLayoutNode >> privateExtent [
	"Return the size of the node in the parent coordinate system"
	<return: #Point>
	
	^ measurement position
]

{ #category : #private }
BlNewLayoutNode >> privateMeasure: anExtentSpecOrBlock [
	measurement := measurement measure: self with: anExtentSpecOrBlock
]

{ #category : #private }
BlNewLayoutNode >> privateMeasurement [
	<return: #BlLayoutNodeMeasurement>
	
	^ measurement
]

{ #category : #private }
BlNewLayoutNode >> privateMeasurement: aBlLayoutNodeMeasurement [	
	measurement := aBlLayoutNodeMeasurement
]

{ #category : #private }
BlNewLayoutNode >> privatePosition [
	"Return a position of the top left corner in the parent coordinate system"
	<return: #Point>
	
	^ measurement position
]

{ #category : #private }
BlNewLayoutNode >> privatePosition: aPoint [
	"Set position of the top left corner in the parent coordinate system"

	measurement position: aPoint
]

{ #category : #'api - decoration' }
BlNewLayoutNode >> transformationDo: aBlock [
	decoration transformationDo: aBlock
]

{ #category : #accessing }
BlNewLayoutNode >> userData [
	<return: #Dictionary>
	
	^ userData ifNil: [ userData := Dictionary new ]
]

{ #category : #converting }
BlNewLayoutNode >> withElement: anElement [
	decoration := self decoration withElement: anElement
]
