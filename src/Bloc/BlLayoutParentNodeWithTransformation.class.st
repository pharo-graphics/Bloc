Class {
	#name : #BlLayoutParentNodeWithTransformation,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutParentNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutParentNode classTrait',
	#instVars : [
		'parentNode',
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> children [
	<return: #Collection of: #BlLayoutNode>

	^ parentNode children
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> children: aBlLayoutNodeChildren [
	parentNode children: aBlLayoutNodeChildren
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> constraints [
	^ parentNode constraints
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> constraints: aBlLayoutConstraints [
	parentNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithTransformation >> extent [
	^ parentNode extent
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithTransformation >> extent: aPoint [

	parentNode extent: aPoint.
	self transformation boundingRectangle:
		(BlBounds origin: self position extent: aPoint)
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithTransformation >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ parentNode extentSpec
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithTransformation >> extentSpec: aBlExtentMeasurementSpec [
	parentNode extentSpec: aBlExtentMeasurementSpec
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> parent [
	^ parentNode parent
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> parentNode [
	^ parentNode
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> position [
	^ parentNode position
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> position: aPoint [

	parentNode position: aPoint.
	self transformation boundingRectangle:
		(BlBounds origin: aPoint extent: self extent)
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformation [
	<return: #BlElementTransformation>
	self
		assert: [ transformation notNil ]
		description: [ 'Transformation should be set before accessing it' ].

	^ transformation
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformation: aBlElementTransformation [

	transformation := aBlElementTransformation asCachedTransformation
		                  boundingRectangle:
		                  (BlBounds
			                   origin: self position
			                   extent: self extent)
]

{ #category : #accessing }
BlLayoutParentNodeWithTransformation >> transformationDo: aBlock [
	aBlock value: transformation
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithTransformation >> withFilter: aSelectBlock [
	^ BlLayoutParentNodeWithFilter new
		parentNode: self;
		filterBlock: aSelectBlock;
		children: (self children select: aSelectBlock)
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithTransformation >> withTransformation: aBlElementTransformation [
	^ BlLayoutParentNodeWithTransformation new
		parentNode: parentNode;
		transformation: aBlElementTransformation
]
