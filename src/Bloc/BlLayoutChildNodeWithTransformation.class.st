Class {
	#name : #BlLayoutChildNodeWithTransformation,
	#superclass : #BlLayoutNonLeafChildNode,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> boundsToParent: aBlBounds [

	^ transformation transformBounds: aBlBounds
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> extent [
	"Return the size of the node in the parent coordinate system"

	^ self extentToParent: childNode extent
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> extentToParent: aPoint [

	^ (transformation transformBounds: (BlBounds origin: 0@0 extent: aPoint)) extent
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> layoutBounds [

	| aDelta |
	"a delta represents by how much the layout bounds should be moved to accomodate transformation"
	aDelta := (self boundsToParent:
		           (BlBounds
			            origin: 0 @ 0
			            extent: self privateMeasurement extent)) origin.
	aDelta := aDelta - (self pointToParent: 0 @ 0).

	^ BlBounds
		  origin: self privateMeasurement position - aDelta
		  extent: self privateMeasurement extent
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> matrix: aBlMatrix [

	self transformation:
		(BlElementAbsoluteTransformation matrix: aBlMatrix)
]

{ #category : #'api - measure' }
BlLayoutChildNodeWithTransformation >> measure: anExtentSpecOrBlock [

	childNode measure: anExtentSpecOrBlock.

	self transformation boundingRectangle:
		(Rectangle origin: 0.0 @ 0.0 extent: self privateMeasurement extent)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> measurement: aBlLayoutNodeMeasurement [

	childNode measurement: aBlLayoutNodeMeasurement.

	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before measurement' ].

	self transformation bounds:
		(BlBounds origin: 0.0 @ 0.0 extent: self privateMeasurement extent)
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> pointToLocal: aPoint [

	^ self transformation inverseTransformPoint: aPoint
]

{ #category : #'api - transformation' }
BlLayoutChildNodeWithTransformation >> pointToParent: aPoint [

	^ transformation transformPoint: aPoint
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> position [

	^ childNode position + (self pointToParent: 0 @ 0)
]

{ #category : #'api - geometry' }
BlLayoutChildNodeWithTransformation >> position: aPoint [

	childNode position: aPoint - (self pointToParent: 0 @ 0)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformation [

	^ transformation
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformation: aBlElementTransformation [

	transformation :=
		aBlElementTransformation asCachedTransformationIn:
			(Rectangle
				origin: 0.0 @ 0.0
				extent: self privateMeasurement extent)
]

{ #category : #accessing }
BlLayoutChildNodeWithTransformation >> transformationDo: aBlock [

	aBlock value: transformation asElementTransformation
]

{ #category : #converting }
BlLayoutChildNodeWithTransformation >> withTransformation: aBlElementTransformation [

	self transformation: aBlElementTransformation
]

{ #category : #converting }
BlLayoutChildNodeWithTransformation >> withoutTransformation [

	^ childNode
]
