"
I represent a leaf child node.
"
Class {
	#name : #BlLayoutChildNode,
	#superclass : #BlAbstractLayoutChildNode,
	#instVars : [
		'parent',
		'measurement',
		'constraints',
		'userData',
		'actions'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutChildNode >> children [

	^ #(  )
]

{ #category : #accessing }
BlLayoutChildNode >> constraints [

	^ constraints
]

{ #category : #accessing }
BlLayoutChildNode >> constraints: aBlLayoutConstraints [

	constraints := aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> extent [
	"Return the size of the node in the parent coordinate system"

	^ measurement extent
]

{ #category : #initialization }
BlLayoutChildNode >> initialize [

	super initialize.

	measurement := BlLayoutNodeNullMeasurement new.
	actions := Stack new
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> layoutBounds [

	^ BlBounds
		origin: self position
		extent: measurement extent
]

{ #category : #'api - measure' }
BlLayoutChildNode >> measure: anExtentSpecOrBlock [

	measurement := measurement measure: self with: anExtentSpecOrBlock
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
BlLayoutChildNode >> parent: aNode [

	parent := aNode
]

{ #category : #'api - actions' }
BlLayoutChildNode >> popAction [

	^ actions
		ifEmpty: [ nil ]
		ifNotEmpty: [ :theActions | theActions pop ]
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> position [
	"Return a position of the top left corner in the parent coordinate system"
	
	^ measurement position
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> position: aPoint [
	"Set position of the top left corner in the parent coordinate system"
	
	measurement position: aPoint
]

{ #category : #printing }
BlLayoutChildNode >> printOn: aStream [

	aStream
		nextPutAll: 'Node position: ';
		print: measurement position;
		nextPutAll: ' extent: ';
		print: measurement extent
]

{ #category : #accessing }
BlLayoutChildNode >> privateMeasurement [
	
	^ measurement
]

{ #category : #'api - actions' }
BlLayoutChildNode >> pushAction: aBlLayoutNodeElementAction [

	actions push: aBlLayoutNodeElementAction
]

{ #category : #accessing }
BlLayoutChildNode >> transformationDo: aBlock [
]

{ #category : #accessing }
BlLayoutChildNode >> userData [
	
	^ userData ifNil: [ userData := Dictionary new ]
]

{ #category : #converting }
BlLayoutChildNode >> withElement: aBlElement [

	^ BlLayoutChildNodeWithElement new
		  childNode: self;
		  element: aBlElement;
		  yourself
]

{ #category : #converting }
BlLayoutChildNode >> withMatrix: aBlMatrix [

	^ BlLayoutChildNodeWithTransformation new
		  childNode: self;
		  matrix: aBlMatrix;
		  yourself
]

{ #category : #converting }
BlLayoutChildNode >> withTransformation: aBlElementTransformation [

	^ BlLayoutChildNodeWithTransformation new
		  childNode: self;
		  transformation: aBlElementTransformation;
		  yourself
]

{ #category : #converting }
BlLayoutChildNode >> withoutElement [
	"Return a layout node that does not know the element"

	^ self
]

{ #category : #converting }
BlLayoutChildNode >> withoutTransformation [

	^ self
]
