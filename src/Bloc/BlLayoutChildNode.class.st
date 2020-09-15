Class {
	#name : #BlLayoutChildNode,
	#superclass : #BlLayoutNode,
	#instVars : [
		'parent',
		'measurement',
		'layoutBounds',
		'transformation'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - resizer' }
BlLayoutChildNode >> hMatchParent [
	self constraints horizontal matchParent
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> horizontalResizer [
	^ self constraints horizontal resizer
]

{ #category : #initialization }
BlLayoutChildNode >> initialize [
	super initialize.
	
	measurement := BlLayoutNodeNullMeasurement new.
	parent := nil
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> isHorizontalMatchParent [
	^ self horizontalResizer isMatchParent
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> isVerticalMatchParent [
	^ self verticalResizer isMatchParent
]

{ #category : #accessing }
BlLayoutChildNode >> layoutBounds [
	<return: #BlBounds>

	^ layoutBounds
]

{ #category : #accessing }
BlLayoutChildNode >> layoutBounds: aBlLayoutBounds [
	self
		assert: [ aBlLayoutBounds isKindOf: BlLayoutBounds ]
		description: [ 'Must be an instance of a special layout bounds class' ].

	layoutBounds := aBlLayoutBounds inLocal asBounds.
	transformation ifNotNil: [ :aTransformation | aTransformation bounds: (BlBounds origin: 0.0@0.0 extent: layoutBounds extent) ]
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> matchParent [
	self
		hMatchParent;
		vMatchParent
]

{ #category : #'api - transformation' }
BlLayoutChildNode >> matrix: aBlMatrix [
	self transformation: (BlElementAbsoluteTransformation matrix: aBlMatrix)
]

{ #category : #measure }
BlLayoutChildNode >> measure: anExtentSpec [
	measurement := measurement measure: self with: anExtentSpec.
	transformation ifNotNil: [ :aTransformation | aTransformation bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent) ]
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> measuredBounds [
	<return: #BlLayoutBoundsInLocal>
	
	^ BlLayoutBoundsInLocal new
		position: self measurement position;
		extent: self measurement extent;
		transformation: transformation
]

{ #category : #'api - geometry' }
BlLayoutChildNode >> measuredExtent [
	"Return the measured extent of the child node in the child's coordinate system
	without taking child's transformation into account"
	<return: #BlLayoutExtent>

	^ BlLayoutExtentInLocal new
		size: self measurement extent;
		transformation: transformation
]

{ #category : #accessing }
BlLayoutChildNode >> measurement [
	<return: #BlLayoutNodeMeasurement>

	^ measurement
]

{ #category : #accessing }
BlLayoutChildNode >> measurement: aBlLayoutNodeMeasurement [
	measurement := aBlLayoutNodeMeasurement.
	transformation ifNotNil: [ :aTransformation | aTransformation bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent) ]
]

{ #category : #accessing }
BlLayoutChildNode >> parent [
	^ parent
]

{ #category : #accessing }
BlLayoutChildNode >> parent: anObject [
	parent := anObject
]

{ #category : #'api - transformation' }
BlLayoutChildNode >> pointToLocal: aPoint [
	^ transformation
		ifNil: [ aPoint ]
		ifNotNil: [ :aTransformation | aTransformation inverseTransformPoint: aPoint ]
]

{ #category : #'api - transformation' }
BlLayoutChildNode >> pointToParent: aPoint [
	^ transformation
		ifNil: [ aPoint ]
		ifNotNil: [ :aTransformation | aTransformation transformPoint: aPoint ]
]

{ #category : #'api - transformation' }
BlLayoutChildNode >> transformation: aBlElementTransformation [
	transformation := aBlElementTransformation
		ifNotNil: [ :aTransformation |
			aTransformation asCachedTransformation
				bounds: (BlBounds origin: 0.0@0.0 extent: self measurement extent)]
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> vExact: aNumber [
	self constraints vertical exact: aNumber
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> vMatchParent [
	self constraints vertical matchParent
]

{ #category : #'api - resizer' }
BlLayoutChildNode >> verticalResizer [
	^ self constraints vertical resizer
]
