Class {
	#name : #BlLayoutParentNodeWithFilter,
	#superclass : #BlLayoutNode,
	#traits : 'TBlLayoutNode + TBlLayoutParentNode',
	#classTraits : 'TBlLayoutNode classTrait + TBlLayoutParentNode classTrait',
	#instVars : [
		'parentNode',
		'filter',
		'children'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> children [
	<return: #Collection of: #BlLayoutNode>

	^ children
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> children: aBlLayoutNodeChildren [
	children := aBlLayoutNodeChildren as: BlLayoutNodeChildren.
	children do: [ :eachChild | eachChild parent: self parent ]
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> constraints [
	^ parentNode constraints
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> constraints: aBlLayoutConstraints [
	parentNode constraints: aBlLayoutConstraints
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithFilter >> extent [
	^ parentNode extent
]

{ #category : #'api - geometry' }
BlLayoutParentNodeWithFilter >> extent: aPoint [
	parentNode extent: aPoint
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithFilter >> extentSpec [
	<return: #BlExtentMeasurementSpec>

	^ parentNode extentSpec
]

{ #category : #'api - extent spec' }
BlLayoutParentNodeWithFilter >> extentSpec: aBlExtentMeasurementSpec [
	parentNode extentSpec: aBlExtentMeasurementSpec
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> filterBlock: aBlockClosure [
	filter := aBlockClosure
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> parent [
	^ parentNode parent
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> parentNode [
	^ parentNode
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> parentNode: anObject [
	parentNode := anObject
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> position [
	^ parentNode position
]

{ #category : #accessing }
BlLayoutParentNodeWithFilter >> position: aPoint [
	parentNode position: aPoint
]

{ #category : #'api - converting' }
BlLayoutParentNodeWithFilter >> withFilter: aSelectBlockOrFilterObject [
	"implement filter as an object to support comparison and not filter twice"
	filter = aSelectBlockOrFilterObject
		ifTrue: [ ^ self ].

	^ self class new
		parentNode: self;
		filterBlock: aSelectBlockOrFilterObject;
		children: (self children select: aSelectBlockOrFilterObject)
]
